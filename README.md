# Jekyll SEO Tag - Enhanced Fork

[![Gem Version](https://img.shields.io/badge/gem-2.8.0-blue.svg)](https://rubygems.org/gems/jekyll-seo-tag)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE.txt)

A Jekyll plugin to add metadata tags for search engines and social networks with **enhanced features** for complex SEO requirements.

## 🌟 What's Different in This Fork?

This enhanced version extends the official [jekyll-seo-tag](https://github.com/jekyll/jekyll-seo-tag) with 8 powerful features:

1. **Platform-Specific Titles** - Different titles for browser tab, Open Graph, and Twitter
2. **Platform-Specific Descriptions** - Optimized descriptions per platform
3. **Audio Metadata** - Full `og:audio` support for podcasts and music
4. **Video Metadata** - Complete video metadata with dimensions
5. **Explicit Type Control** - Override `og:type` detection
6. **Robots Meta Tag** - Per-page indexing control
7. **Twitter Customization** - Independent Twitter Card fields
8. **Flexible Front Matter** - Support both colon and nested notation

## 📦 Installation

Add this line to your site's `Gemfile`:

```ruby
gem 'jekyll-seo-tag', github: 'Bhoj-karki/jekyll-seo-tag'
```

Or for local development:

```ruby
gem 'jekyll-seo-tag', path: '../jekyll-seo-tag'
```

And then add to your site's `_config.yml`:

```yaml
plugins:
  - jekyll-seo-tag
```

Add the following tag to your `_layouts/default.html` (or wherever your `<head>` is):

```liquid
{% seo %}
```

## 🚀 Quick Start

### Basic Usage (Standard Features)

```yaml
---
title: "My Page Title"
description: "My page description"
image: "/assets/image.jpg"
---
```

### Enhanced Usage (New Features)

```yaml
---
# Different titles for different contexts
page_title: "Short Browser Tab Title"
title: "Full Page Title"
og:title: "Engaging Social Media Title"
twitter:title: "Twitter-Specific Title"

# Platform-optimized descriptions
description: "Meta description for search engines"
og:description: "Social media description (< 155 chars)"
twitter:description: "Twitter-optimized description"

# Audio metadata (for podcast/music pages)
og:audio: "https://example.com/podcast.mp3"
og:audio:type: "audio/mpeg"

# Video metadata
og:video: "https://example.com/video.mp4"
og:video:width: "1280"
og:video:height: "720"

# Explicit content type
og:type: "article"

# Search engine control
robots: "index, follow"

# Twitter Card customization
twitter:card: "summary_large_image"
twitter:image: "/assets/twitter-optimized.jpg"
---
```

## 📚 Documentation

### Enhanced Features

#### 1. Platform-Specific Titles

Define different titles for different contexts:

```yaml
page_title: "Buy Now"                    # Browser tab (short)
title: "Buy Our Amazing Product"          # Page content
og:title: "Get 50% Off Today!"           # Facebook/LinkedIn (engaging)
twitter:title: "Limited Time Offer!"      # Twitter (urgent)
```

**Priority**: `twitter:title` → `og:title` → `page_title` → `title` → site title

#### 2. Platform-Specific Descriptions

Optimize descriptions for each platform:

```yaml
description: "Product description optimized for search engines with keywords"
og:description: "Engaging description for social media sharing (< 155 chars)"
twitter:description: "Twitter-friendly description with hashtags (< 200 chars)"
```

**Character Recommendations**:
- Meta description: ~155 characters
- OG description: ~155 characters
- Twitter description: ~200 characters

#### 3. Audio Metadata

Perfect for podcasts, music, and audio content:

```yaml
og:audio: "https://example.com/episode-1.mp3"
og:audio:secure_url: "https://example.com/episode-1.mp3"
og:audio:type: "audio/mpeg"
```

**Supported Formats**: MP3, OGG, WAV, AAC

**Result**: Rich audio previews on Facebook with player

#### 4. Video Metadata

Enhanced video metadata for better previews:

```yaml
og:video: "https://example.com/video.mp4"
og:video:secure_url: "https://example.com/video.mp4"
og:video:type: "video/mp4"
og:video:width: "1920"
og:video:height: "1080"
```

**Result**: Embedded video players on social platforms

#### 5. Explicit Type Control

Override automatic type detection:

```yaml
og:type: "article"  # article, website, video.movie, music.song, book, etc.
```

**Default Detection**:
- Posts with dates → `BlogPosting`
- Homepage/About → `WebSite`
- Other pages → `WebPage`

[See full list of Open Graph types](https://ogp.me/#types)

#### 6. Robots Meta Tag

Control search engine indexing per page:

```yaml
robots: "index, follow"
# or
robots: "noindex, nofollow"
# or
robots: "index, nofollow"
```

**Common Directives**:
- `index, follow` - Allow indexing and following links (default)
- `noindex, follow` - Don't index page, but follow links
- `noindex, nofollow` - Private page, don't index or follow
- `index, nofollow` - Index page but don't follow links

#### 7. Twitter Card Customization

Complete control over Twitter Cards:

```yaml
twitter:card: "summary_large_image"
twitter:title: "Twitter-Specific Title"
twitter:description: "Twitter-Specific Description"
twitter:image: "/assets/twitter-1200x630.jpg"
```

**Card Types**:
- `summary` - Small image card
- `summary_large_image` - Large image card (recommended)
- `app` - App card
- `player` - Video/audio player

#### 8. Flexible Front Matter Notation

Both syntaxes work identically:

**Colon Notation** (concise):
```yaml
og:title: "My Title"
og:description: "My Description"
twitter:card: "summary_large_image"
```

**Nested Notation** (YAML standard):
```yaml
og:
  title: "My Title"
  description: "My Description"
twitter:
  card: "summary_large_image"
```

## 🎯 Use Cases

### Podcast Website

```yaml
---
page_title: "Episode 42"
title: "Episode 42: How to Build Amazing Jekyll Plugins"
description: "In this episode, we discuss building Jekyll plugins..."

og:audio: "https://example.com/podcast/episode-42.mp3"
og:audio:type: "audio/mpeg"
og:type: "music.song"

twitter:card: "player"
---
```

### Video Content

```yaml
---
title: "How to Use Jekyll SEO Tag"
og:video: "https://example.com/videos/tutorial.mp4"
og:video:width: "1920"
og:video:height: "1080"
og:type: "video.other"
---
```

### Multi-Platform Marketing

```yaml
---
page_title: "Buy Now - 50% Off"
og:title: "Get 50% Off Our Best-Selling Product Today!"
twitter:title: "🔥 FLASH SALE: 50% OFF - Limited Time!"

og:description: "Premium quality product at an unbeatable price. Shop now!"
twitter:description: "Don't miss out! Our best-selling product is 50% off today only. #Sale #Deal"

twitter:image: "/assets/twitter-promo.jpg"
og:image: "/assets/facebook-promo.jpg"
---
```

### Private/Draft Pages

```yaml
---
title: "Draft Article"
robots: "noindex, nofollow"
---
```

## 🧪 Testing

Run the test suite:

```bash
bundle exec rspec
```

Run specific test file:

```bash
bundle exec rspec spec/jekyll_seo_tag/drop_spec.rb
```

## 🔍 Validating Your SEO Tags

After building your site, validate the generated tags:

### Online Validators

- **Open Graph**: https://www.opengraph.xyz/
- **Twitter Card**: https://cards-dev.twitter.com/validator
- **Facebook Debugger**: https://developers.facebook.com/tools/debug/
- **LinkedIn Inspector**: https://www.linkedin.com/post-inspector/
- **Schema.org**: https://validator.schema.org/

### Command Line

```bash
# Build your site
bundle exec jekyll build

# View generated tags
cat _site/your-page.html | grep -A 30 "Jekyll SEO tag"

# Check specific tags
cat _site/your-page.html | grep "og:title"
cat _site/your-page.html | grep "twitter:card"
cat _site/your-page.html | grep "og:audio"
```

## 📊 Generated Output Example

With this front matter:

```yaml
---
page_title: "LOVE Star Art"
og:title: "LOVE Star Art - Understanding Love"
og:description: "LOVE Star Art created with letters L, O, V, E"
og:type: "article"
og:audio: "https://example.com/love.mp3"
twitter:card: "summary_large_image"
twitter:title: "LOVE Star Art ❤️"
robots: "index, follow"
---
```

Generates:

```html
<!-- Begin Jekyll SEO tag v2.8.0 -->
<title>LOVE Star Art</title>

<meta property="og:title" content="LOVE Star Art - Understanding Love" />
<meta property="og:description" content="LOVE Star Art created with letters L, O, V, E" />
<meta property="og:type" content="article" />
<meta property="og:url" content="https://example.com/love" />

<meta property="og:audio" content="https://example.com/love.mp3" />
<meta property="og:audio:secure_url" content="https://example.com/love.mp3" />
<meta property="og:audio:type" content="audio/mpeg" />

<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="LOVE Star Art ❤️" />

<meta name="robots" content="index, follow" />

<!-- End Jekyll SEO tag -->
```

## 🔄 Migration from Standard Plugin

### No Breaking Changes

All existing front matter continues to work! The enhancements are additive:

**Before** (still works):
```yaml
---
title: "My Page"
description: "My description"
---
```

**After** (enhanced, optional):
```yaml
---
page_title: "My Page"
title: "My Page Title"
description: "My description"
og:title: "My Social Title"
twitter:title: "My Twitter Title"
---
```

### Gradual Enhancement

You can enhance pages gradually:
1. Start with one page
2. Test the output
3. Validate with online tools
4. Apply to more pages

## 🤝 Contributing

This is a fork of the official jekyll-seo-tag with enhancements for specific use cases. For issues specific to the enhanced features, please open an issue in this repository.

For general jekyll-seo-tag issues, see the [official repository](https://github.com/jekyll/jekyll-seo-tag).

## 📝 Development

### Setup

```bash
git clone https://github.com/Bhoj-karki/jekyll-seo-tag.git
cd jekyll-seo-tag
bundle install
```

### Running Tests

```bash
bundle exec rspec
```

### Building the Gem

```bash
gem build jekyll-seo-tag.gemspec
```

## 📖 Additional Documentation

- [ENHANCEMENTS.md](ENHANCEMENTS.md) - Detailed enhancement documentation
- [Official jekyll-seo-tag docs](https://github.com/jekyll/jekyll-seo-tag) - Base functionality
- [Open Graph Protocol](https://ogp.me/) - OG tag specifications
- [Twitter Cards](https://developer.twitter.com/en/docs/twitter-for-websites/cards/overview/abouts-cards) - Twitter Card documentation

## 🙏 Credits

Based on the excellent [jekyll-seo-tag](https://github.com/jekyll/jekyll-seo-tag) by the Jekyll team.

Enhanced with additional features for complex SEO requirements.

## 📄 License

MIT License - Same as jekyll-seo-tag

## 🔗 Links

- **GitHub**: https://github.com/Bhoj-karki/jekyll-seo-tag
- **Original Plugin**: https://github.com/jekyll/jekyll-seo-tag
- **Example Site**: [Good Works On Earth](https://goodworksonearth.org) (Using this fork)

---

**Made with ❤️ for SEO-conscious Jekyll users**
