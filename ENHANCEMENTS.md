# Jekyll SEO Tag - Custom Enhancements

## Overview

This forked version of jekyll-seo-tag includes enhancements specifically designed for sites with complex SEO requirements, including support for separate titles across different platforms, audio/video metadata, and fine-grained control over Open Graph and Twitter Card properties.

## New Features

### 1. Separate Platform-Specific Titles

You can now define different titles for different contexts:

```yaml
---
page_title: "Short Browser Tab Title"
title: "Full Page Title for Content"
og:title: "Social Media Sharing Title (Facebook, LinkedIn)"
twitter:title: "Twitter-Specific Title"
---
```

**How it works**:
- `page_title` - Shows in browser tab (falls back to `title`)
- `title` - Used in `<title>` tag and as fallback
- `og:title` - Used for Open Graph (Facebook, LinkedIn)
- `twitter:title` - Used specifically for Twitter Cards

**Priority**: Specific field → title → site title

### 2. Separate Platform-Specific Descriptions

Similarly, descriptions can be customized per platform:

```yaml
---
description: "Meta description for search engines"
og:description: "Engaging description for social media (< 155 chars)"
twitter:description: "Twitter-optimized description"
---
```

**Character limits**:
- Meta description: ~155 characters
- OG description: ~155 characters
- Twitter description: ~200 characters

### 3. Audio Metadata Support

Perfect for pages with audio content (podcasts, music, sound):

```yaml
---
og:audio: "https://example.com/audio.mp3"
og:audio:secure_url: "https://example.com/audio.mp3"
og:audio:type: "audio/mpeg"
---
```

**Generated tags**:
```html
<meta property="og:audio" content="https://example.com/audio.mp3" />
<meta property="og:audio:secure_url" content="https://example.com/audio.mp3" />
<meta property="og:audio:type" content="audio/mpeg" />
```

**Supported formats**: MP3, OGG, WAV, etc.

### 4. Video Metadata Support

Enhanced video metadata for rich video previews:

```yaml
---
og:video: "https://example.com/video.mp4"
og:video:secure_url: "https://example.com/video.mp4"
og:video:type: "video/mp4"
og:video:width: "1280"
og:video:height: "720"
---
```

### 5. Explicit Content Type Control

Override automatic type detection:

```yaml
---
og:type: "article"  # article, website, video.movie, music.song, etc.
---
```

**Default behavior**:
- Pages with dates → `article`
- Homepage/About → `website`
- Other pages → `webpage`

**Override**: Set `og:type` explicitly in front matter

### 6. Robots Meta Tag

Control search engine indexing per page:

```yaml
---
robots: "index, follow"
# or
robots: "noindex, nofollow"
# or
robots: "index, nofollow"
---
```

**Common values**:
- `index, follow` - Allow indexing and following links (default)
- `noindex, follow` - Don't index, but follow links
- `noindex, nofollow` - Don't index or follow links
- `index, nofollow` - Index page but don't follow links

### 7. Twitter Card Customization

Fine-grained Twitter Card control:

```yaml
---
twitter:card: "summary_large_image"
twitter:title: "Custom Twitter Title"
twitter:description: "Custom Twitter Description"
twitter:image: "/path/to/twitter-optimized-image.jpg"
---
```

**Card types**:
- `summary` - Small image card
- `summary_large_image` - Large image card (recommended)
- `app` - App card
- `player` - Video/audio player card

### 8. Nested Front Matter Support

The plugin now supports both formats:

**Colon notation** (recommended for simplicity):
```yaml
---
og:title: "My Title"
og:description: "My Description"
twitter:card: "summary_large_image"
twitter:title: "Twitter Title"
---
```

**Nested notation** (YAML standard):
```yaml
---
og:
  title: "My Title"
  description: "My Description"
  audio: "https://example.com/audio.mp3"
twitter:
  card: "summary_large_image"
  title: "Twitter Title"
---
```

Both formats work identically!

## Complete Front Matter Example

Here's a comprehensive example showing all features:

```yaml
---
layout: default

# Browser tab and page titles
page_title: "MOTHERS Star Art"
title: "MOTHERS Star Art shares the essence of motherhood"
description: "MOTHERS Star Art created using letters M, O, T, H, E, R, S"

# Open Graph (Facebook, LinkedIn, etc.)
og:title: "MOTHERS Star Art - Understanding Motherhood"
og:description: "MOTHERS Star Art reveals the essence of motherhood (EHMORST)"
og:type: "article"
og:image: "/assets/images/mothers-art.jpg"

# Twitter Card
twitter:card: "summary_large_image"
twitter:title: "MOTHERS Star Art on Twitter"
twitter:description: "Experience MOTHERS Star Art - letters M, O, T, H, E, R, S"
twitter:image: "/assets/images/mothers-twitter.jpg"

# Audio (for pages with audio content)
og:audio: "https://goodworksonearth.org/assets/mp3/mothers.mp3"
og:audio:secure_url: "https://goodworksonearth.org/assets/mp3/mothers.mp3"
og:audio:type: "audio/mpeg"

# SEO directives
robots: "index, follow"
sitemap: true

# Author info
author: "kathy onu nee uno"
copyright: "&copy; 2025 Good Works On Earth"

# Custom styles
css: stararts.css

# Permalink
permalink: /mothers
---
```

## Migration from Standard Plugin

If you're migrating from the standard jekyll-seo-tag:

### 1. Update Gemfile

```ruby
# Old
gem "jekyll-seo-tag"

# New - use local fork
gem "jekyll-seo-tag", path: "../jekyll-seo-tag"
```

### 2. Add Platform-Specific Fields (Optional)

You can enhance your existing front matter:

**Before**:
```yaml
---
title: "My Page Title"
description: "My description"
---
```

**After** (enhanced):
```yaml
---
page_title: "Browser Tab Title"
title: "My Page Title"
description: "My description"
og:title: "Social Media Title"
og:description: "Social media description"
twitter:title: "Twitter-specific title"
---
```

### 3. No Breaking Changes

All existing front matter continues to work! The enhancements are additive:
- If you don't use the new fields, behavior is identical to standard plugin
- New fields are optional - only use what you need
- Fallback chain ensures everything still works

## Field Priority and Fallbacks

### Title Priority
1. `twitter:title` (Twitter)
2. `og:title` (Open Graph)
3. `page_title` (browser tab)
4. `title` (page title)
5. Site title

### Description Priority
1. `twitter:description` (Twitter)
2. `og:description` (Open Graph)
3. `description` (meta description)
4. Excerpt or site description

### Image Priority
1. `twitter:image` (Twitter)
2. `og:image` (Open Graph)
3. `image` field
4. Site default image

## Use Cases

### 1. Star Arts Site
Perfect for sites like Good Works On Earth where each page needs:
- Concise browser title
- Detailed content title
- Engaging social media title
- Platform-optimized descriptions

### 2. Podcast/Audio Sites
Use `og:audio` for rich audio previews on Facebook:
```yaml
---
og:audio: "/podcast/episode-1.mp3"
og:audio:type: "audio/mpeg"
---
```

### 3. Video Content
Enhanced video metadata for YouTube-style pages:
```yaml
---
og:video: "/videos/tutorial.mp4"
og:video:width: "1920"
og:video:height: "1080"
---
```

### 4. Private Pages
Control search engine access:
```yaml
---
robots: "noindex, nofollow"  # Keep page private
---
```

## Testing Your SEO Tags

After building your site, test the generated tags:

### 1. View Source
```bash
cat _site/your-page.html | head -50
```

### 2. Online Validators
- **Open Graph**: https://www.opengraph.xyz/
- **Twitter Card**: https://cards-dev.twitter.com/validator
- **Schema.org**: https://validator.schema.org/

### 3. Social Media Debuggers
- **Facebook**: https://developers.facebook.com/tools/debug/
- **LinkedIn**: https://www.linkedin.com/post-inspector/
- **Twitter**: https://cards-dev.twitter.com/validator

## Troubleshooting

### Issue: og:title not showing
**Solution**: Make sure you're using `og:title` not `og:page_title`

### Issue: Audio not appearing in Facebook preview
**Solution**: Ensure audio file is:
- Publicly accessible (HTTPS)
- Correct MIME type
- Not blocked by robots.txt

### Issue: Different titles not working
**Solution**: Check field names - use `page_title`, `og:title`, `twitter:title` (note the colons)

### Issue: Nested format not working
**Solution**: Both formats work, but don't mix them:
```yaml
# Good
og:title: "Title"
og:description: "Desc"

# Good
og:
  title: "Title"
  description: "Desc"

# Bad - don't mix
og:title: "Title"
og:
  description: "Desc"
```

## Development

### Building the Gem
```bash
cd jekyll-seo-tag
gem build jekyll-seo-tag.gemspec
```

### Testing Locally
```bash
cd ../my-jekyll-site
bundle exec jekyll build
cat _site/index.html | grep -A 30 "meta"
```

### Running Tests
```bash
cd jekyll-seo-tag
bundle install
bundle exec rspec
```

## Contributing

Found a bug or want to suggest an enhancement? This is a custom fork, but improvements are welcome!

## License

MIT License - Same as jekyll-seo-tag

## Credits

Based on the excellent [jekyll-seo-tag](https://github.com/jekyll/jekyll-seo-tag) by Jekyll team.
Enhanced for complex SEO requirements by the Good Works On Earth project.
