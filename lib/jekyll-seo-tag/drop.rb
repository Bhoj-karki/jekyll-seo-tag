# frozen_string_literal: true

module Jekyll
  class SeoTag
    class Drop < Jekyll::Drops::Drop
      include Jekyll::SeoTag::UrlHelper

      TITLE_SEPARATOR = " | "
      FORMAT_STRING_METHODS = [
        :markdownify, :strip_html, :normalize_whitespace, :escape_once,
      ].freeze
      HOMEPAGE_OR_ABOUT_REGEX = %r!^/(about/)?(index.html?)?$!.freeze

      EMPTY_READ_ONLY_HASH = {}.freeze
      private_constant :EMPTY_READ_ONLY_HASH

      def initialize(text, context)
        @obj = EMPTY_READ_ONLY_HASH
        @mutations = {}
        @text = text
        @context = context
      end

      def version
        Jekyll::SeoTag::VERSION
      end

      # Should the `<title>` tag be generated for this page?
      def title?
        return false unless title
        return @display_title if defined?(@display_title)

        @display_title = (@text !~ %r!title=false!i)
      end

      def site_title
        @site_title ||= format_string(site["title"] || site["name"])
      end

      def site_tagline
        @site_tagline ||= format_string site["tagline"]
      end

      def site_description
        @site_description ||= format_string site["description"]
      end

      # Returns the page title without site title or description appended
      #
      # ENHANCEMENT: Now supports explicit 'page_title' field for browser tab titles
      # This allows different titles for the browser tab vs social media sharing
      #
      # Priority:
      #   1. page["page_title"] - Explicit browser tab title
      #   2. page["title"] - Standard page title
      #   3. page["title_category"] - Category-based title
      #   4. site_title - Site-wide title
      #
      # Returns the formatted page title string
      #
      # Example front matter:
      #   page_title: "Short Tab Title"
      #   title: "Full Page Title for Content"
      #   og:title: "Social Media Title"
      def page_title
        return @page_title if defined?(@page_title)

        # Check for explicit page_title field first (for browser tab)
        explicit_page_title = format_string(page["page_title"])
        return @page_title = explicit_page_title if explicit_page_title

        title = format_string(page["title"])
        title_category = format_string(page["title_category"])
        @page_title = if title && title_category && title != title_category
                        title + TITLE_SEPARATOR + title_category
                      else
                        title || title_category || site_title
                      end
      end

      def site_tagline_or_description
        site_tagline || site_description
      end

      # Page title with site title or description appended
      # rubocop:disable Metrics/CyclomaticComplexity
      def title
        @title ||= begin
          if site_title && page_title != site_title
            page_title + TITLE_SEPARATOR + site_title
          elsif site_description && site_title
            site_title + TITLE_SEPARATOR + site_tagline_or_description
          else
            page_title || site_title
          end
        end

        return page_number + @title if page_number

        @title
      end
      # rubocop:enable Metrics/CyclomaticComplexity

      def name
        return @name if defined?(@name)

        @name = if seo_name
                  seo_name
                elsif !homepage_or_about?
                  nil
                elsif site_social["name"]
                  format_string site_social["name"]
                elsif site_title
                  site_title
                end
      end

      def description
        @description ||= begin
          value = format_string(page["description"] || page["excerpt"]) || site_description
          snippet(value, description_max_words)
        end
      end

      # A drop representing the page author
      def author
        @author ||= AuthorDrop.new(:page => page, :site => site)
      end

      # A drop representing the JSON-LD output
      def json_ld
        @json_ld ||= JSONLDDrop.new(self)
      end

      # Returns a Drop representing the page's image
      # Returns nil if the image has no path, to preserve backwards compatability
      def image
        @image ||= ImageDrop.new(:page => page, :context => @context)
        @image if @image.path
      end

      def date_modified
        @date_modified ||= begin
          date = page_seo["date_modified"] || page["last_modified_at"].to_liquid || page["date"]
          filters.date_to_xmlschema(date) if date
        end
      end

      def date_published
        @date_published ||= filters.date_to_xmlschema(page["date"]) if page["date"]
      end

      # Returns the Open Graph type of the content
      #
      # ENHANCEMENT: Now supports explicit og:type override in front matter
      # This allows precise control over how content is classified on social platforms
      #
      # Priority:
      #   1. page["og:type"] or page["og"]["type"] - Explicit Open Graph type
      #   2. page_seo["type"] - Type in seo: namespace
      #   3. page["type"] - Simple type field
      #   4. Auto-detection based on page properties:
      #      - Homepage/About → "WebSite"
      #      - Posts with dates → "BlogPosting"
      #      - Other pages → "WebPage"
      #
      # Returns the og:type string
      #
      # Common Open Graph types:
      #   - "article" - Articles, blog posts, news stories
      #   - "website" - Generic websites
      #   - "video.movie" - Movies
      #   - "music.song" - Music tracks
      #   - "book" - Books
      #
      # Example front matter:
      #   og:type: "article"
      #
      # See: https://ogp.me/#types for complete list
      def type
        @type ||= begin
          # Support og:type field directly in front matter
          if page["og:type"] || page["og"]["type"]
            page["og:type"] || page["og"]["type"]
          elsif page_seo["type"]
            page_seo["type"]
          elsif page["type"]
            page["type"]
          elsif homepage_or_about?
            "WebSite"
          elsif page["date"]
            "BlogPosting"
          else
            "WebPage"
          end
        end
      end

      def links
        @links ||= begin
          if page_seo["links"]
            page_seo["links"]
          elsif homepage_or_about? && site_social["links"]
            site_social["links"]
          end
        end
      end

      def logo
        @logo ||= begin
          return unless site["logo"]

          if absolute_url? site["logo"]
            filters.uri_escape site["logo"]
          else
            filters.uri_escape filters.absolute_url site["logo"]
          end
        end
      end

      def page_lang
        @page_lang ||= page["lang"] || site["lang"] || "en_US"
      end

      def page_locale
        @page_locale ||= (page["locale"] || site["locale"] || page_lang).tr("-", "_")
      end

      def canonical_url
        @canonical_url ||= begin
          if page["canonical_url"].to_s.empty?
            filters.absolute_url(page["url"]).to_s.gsub(%r!/index\.html$!, "/")
          else
            page["canonical_url"]
          end
        end
      end

      def description_max_words
        @description_max_words ||= page["seo_description_max_words"] || 100
      end

      # Returns the Open Graph specific title
      #
      # This allows different titles for Open Graph (Facebook, LinkedIn) vs browser tab
      # Supports both colon notation (og:title) and nested notation (og: { title: })
      #
      # Priority:
      #   1. page["og:title"] or page["og"]["title"]
      #   2. Falls back to page_title
      #
      # Returns the formatted og:title string
      #
      # Examples:
      #   og:title: "My Social Media Title"
      #   # or
      #   og:
      #     title: "My Social Media Title"
      def og_title
        @og_title ||= begin
          format_string(page["og:title"] || page["og"]["title"]) || page_title
        end
      end

      # Returns the Open Graph specific description
      #
      # Allows platform-optimized descriptions for social media sharing
      # Automatically truncates to description_max_words (default 100)
      #
      # Priority:
      #   1. page["og:description"] or page["og"]["description"]
      #   2. Falls back to standard description
      #
      # Returns the formatted og:description string (truncated if needed)
      def og_description
        @og_description ||= begin
          value = format_string(page["og:description"] || page["og"]["description"]) || description
          snippet(value, description_max_words) if value
        end
      end

      # Returns the Twitter Card specific title
      #
      # Enables Twitter-optimized titles separate from other platforms
      # Follows fallback chain: twitter:title → og:title → page_title
      #
      # Priority:
      #   1. page["twitter:title"] or page["twitter"]["title"]
      #   2. og_title (Open Graph title)
      #   3. page_title (browser tab title)
      #
      # Returns the formatted twitter:title string
      def twitter_title
        @twitter_title ||= begin
          format_string(page["twitter:title"] || page["twitter"]["title"]) || og_title || page_title
        end
      end

      # Returns the Twitter Card specific description
      #
      # Twitter-optimized description with automatic truncation
      # Follows fallback chain: twitter:description → og:description → description
      #
      # Priority:
      #   1. page["twitter:description"] or page["twitter"]["description"]
      #   2. og_description (Open Graph description)
      #   3. description (standard meta description)
      #
      # Returns the formatted twitter:description string (truncated if needed)
      def twitter_description
        @twitter_description ||= begin
          value = format_string(page["twitter:description"] || page["twitter"]["description"]) || og_description || description
          snippet(value, description_max_words) if value
        end
      end

      # Returns the Twitter Card type
      #
      # Determines which Twitter Card format to use
      # Defaults to "summary_large_image" if image exists, "summary" otherwise
      #
      # Priority:
      #   1. page["twitter:card"] or page["twitter"]["card"]
      #   2. "summary_large_image" if page has image
      #   3. "summary" as fallback
      #
      # Returns the twitter:card type string
      #
      # Common values:
      #   - "summary" - Small image card
      #   - "summary_large_image" - Large image card (recommended)
      #   - "app" - App card
      #   - "player" - Video/audio player card
      def twitter_card
        @twitter_card ||= begin
          page["twitter:card"] || page["twitter"]["card"] ||
          (image ? "summary_large_image" : "summary")
        end
      end

      # Returns the Twitter Card specific image URL
      #
      # Allows different images for Twitter vs other platforms
      # Automatically handles URL escaping and absolute URLs
      #
      # Priority:
      #   1. page["twitter:image"] or page["twitter"]["image"]
      #   2. Falls back to standard image path
      #
      # Returns the escaped, absolute twitter:image URL or nil
      def twitter_image
        @twitter_image ||= begin
          img = page["twitter:image"] || page["twitter"]["image"]
          if img
            if absolute_url?(img)
              filters.uri_escape(img)
            else
              filters.uri_escape(filters.absolute_url(img))
            end
          else
            image&.path
          end
        end
      end

      # Returns the robots meta tag directive
      #
      # Provides per-page control over search engine indexing
      # Set in front matter to control crawler behavior
      #
      # Returns the robots directive string or nil
      #
      # Common values:
      #   - "index, follow" - Allow indexing and following links (default)
      #   - "noindex, follow" - Don't index, but follow links
      #   - "noindex, nofollow" - Don't index or follow links
      #   - "index, nofollow" - Index page but don't follow links
      #
      # Example front matter:
      #   robots: "index, follow"
      def robots
        @robots ||= page["robots"]
      end

      # Returns audio metadata for Open Graph
      #
      # Enables rich audio previews on Facebook and other platforms
      # Supports both colon notation and nested notation
      #
      # Returns a hash with audio properties or nil if no audio specified:
      #   {
      #     "url" => "https://example.com/audio.mp3",
      #     "secure_url" => "https://example.com/audio.mp3",
      #     "type" => "audio/mpeg"
      #   }
      #
      # Example front matter:
      #   og:audio: "https://example.com/podcast.mp3"
      #   og:audio:secure_url: "https://example.com/podcast.mp3"
      #   og:audio:type: "audio/mpeg"
      #
      # Supported formats: MP3, OGG, WAV, etc.
      def audio
        @audio ||= begin
          audio_url = page["og:audio"] || page["og"]["audio"]
          return nil unless audio_url

          {
            "url" => audio_url,
            "secure_url" => page["og:audio:secure_url"] || page["og"]["audio_secure_url"] || audio_url,
            "type" => page["og:audio:type"] || page["og"]["audio_type"] || "audio/mpeg"
          }
        end
      end

      # Returns video metadata for Open Graph
      #
      # Enables rich video previews with player embeds
      # Supports dimensions, types, and secure URLs
      #
      # Returns a hash with video properties or nil if no video specified:
      #   {
      #     "url" => "https://example.com/video.mp4",
      #     "secure_url" => "https://example.com/video.mp4",
      #     "type" => "video/mp4",
      #     "width" => "1280",
      #     "height" => "720"
      #   }
      #
      # Example front matter:
      #   og:video: "https://example.com/video.mp4"
      #   og:video:type: "video/mp4"
      #   og:video:width: "1280"
      #   og:video:height: "720"
      def video
        @video ||= begin
          video_url = page["og:video"] || page["og"]["video"]
          return nil unless video_url

          {
            "url" => video_url,
            "secure_url" => page["og:video:secure_url"] || page["og"]["video_secure_url"] || video_url,
            "type" => page["og:video:type"] || page["og"]["video_type"],
            "width" => page["og:video:width"] || page["og"]["video_width"],
            "height" => page["og:video:height"] || page["og"]["video_height"]
          }
        end
      end

      private

      def filters
        @filters ||= Jekyll::SeoTag::Filters.new(@context)
      end

      def page
        @page ||= @context.registers[:page].to_liquid
      end

      def site
        @site ||= @context.registers[:site].site_payload["site"].to_liquid
      end

      def homepage_or_about?
        page["url"] =~ HOMEPAGE_OR_ABOUT_REGEX
      end

      def page_number
        return unless @context["paginator"] && @context["paginator"]["page"]

        current = @context["paginator"]["page"]
        total = @context["paginator"]["total_pages"]
        paginator_message = site["seo_paginator_message"] || "Page %<current>s of %<total>s for "

        format(paginator_message, :current => current, :total => total) if current > 1
      end

      attr_reader :context

      def fallback_data
        @fallback_data ||= {}
      end

      def format_string(string)
        string = FORMAT_STRING_METHODS.reduce(string) do |memo, method|
          filters.public_send(method, memo)
        end

        string unless string.empty?
      end

      def snippet(string, max_words)
        return string if string.nil?

        result = string.split(%r!\s+!, max_words + 1)[0...max_words].join(" ")
        result.length < string.length ? result.concat("…") : result
      end

      def seo_name
        @seo_name ||= format_string(page_seo["name"]) if page_seo["name"]
      end

      def page_seo
        @page_seo ||= sub_hash(page, "seo")
      end

      def site_social
        @site_social ||= sub_hash(site, "social")
      end

      # Safely returns a sub hash
      #
      # hash - the parent hash
      # key  - the key in the parent hash
      #
      # Returns the sub hash or an empty hash, if it does not exist
      def sub_hash(hash, key)
        if hash[key].is_a?(Hash)
          hash[key]
        else
          EMPTY_READ_ONLY_HASH
        end
      end
    end
  end
end
