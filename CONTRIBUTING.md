# Contributing to Jekyll SEO Tag (Enhanced Fork)

Thank you for your interest in contributing! This enhanced fork maintains backward compatibility with the official jekyll-seo-tag while adding features for complex SEO requirements.

## 🎯 Scope of This Fork

This fork focuses on enhancements for:
- Multi-platform content optimization (different titles/descriptions per platform)
- Rich media metadata (audio, video)
- Fine-grained SEO control (robots, explicit types)
- Flexible front matter syntax

## 🐛 Bug Reports

### For Enhanced Features

If you find a bug in the enhanced features (og:title, twitter:title, audio/video metadata, etc.):

1. **Check existing issues** first
2. **Open a new issue** with:
   - Clear description
   - Front matter example
   - Expected output
   - Actual output
   - Jekyll version
   - Ruby version

### For Base Functionality

For issues with base jekyll-seo-tag functionality, please report to the [official repository](https://github.com/jekyll/jekyll-seo-tag/issues).

## ✨ Feature Requests

### For This Fork

We welcome feature requests related to:
- Additional platform-specific metadata
- New social media platforms
- SEO best practices
- Front matter flexibility

### Guidelines

- **Backward compatibility is essential** - Existing sites must continue to work
- **Follow Open Graph/Twitter Card specs** - Stay standards-compliant
- **Document thoroughly** - Include examples and use cases
- **Test extensively** - Include RSpec tests

## 🔧 Pull Requests

### Before You Start

1. **Discuss major changes** - Open an issue first for large features
2. **Check compatibility** - Ensure backward compatibility
3. **Follow conventions** - Match existing code style

### Development Setup

```bash
# Clone the repository
git clone https://github.com/Bhoj-karki/jekyll-seo-tag.git
cd jekyll-seo-tag

# Install dependencies
bundle install

# Run tests
bundle exec rspec

# Build the gem
gem build jekyll-seo-tag.gemspec
```

### Making Changes

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Write code
   - Add comments
   - Update documentation

3. **Add tests**
   - Add RSpec tests to `spec/jekyll_seo_tag/drop_spec.rb`
   - Test both colon and nested notation
   - Test fallback chains
   - Test edge cases

4. **Update documentation**
   - Update README.md
   - Update ENHANCEMENTS.md
   - Add examples

5. **Run tests**
   ```bash
   bundle exec rspec
   ```

6. **Commit changes**
   ```bash
   git add .
   git commit -m "Add feature: your feature description"
   ```

7. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

8. **Open a Pull Request**
   - Clear description
   - Link to related issues
   - Include examples
   - Show test results

### Pull Request Checklist

- [ ] Code follows existing style
- [ ] Comments added to new methods
- [ ] Tests added for new features
- [ ] Tests pass locally
- [ ] Documentation updated
- [ ] README.md updated with examples
- [ ] ENHANCEMENTS.md updated
- [ ] Backward compatibility maintained
- [ ] No breaking changes

## 📝 Code Style

### Ruby

Follow the existing style:
- 2 spaces for indentation
- Snake_case for methods and variables
- CamelCase for classes
- Meaningful method names
- Comments for public methods

### Documentation Comments

```ruby
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
  # implementation
end
```

### Template Comments

```html
<!-- ENHANCEMENT: Feature description -->
<!-- Additional context about what this does -->
<!-- Front matter example: field: "value" -->
{% if condition %}
  <meta property="..." content="..." />
{% endif %}
```

## 🧪 Testing Guidelines

### Writing Tests

```ruby
context "feature_name" do
  context "with specific input" do
    let(:page_meta) { { "field" => "value" } }

    it "does expected thing" do
      expect(subject.method_name).to eql("expected_value")
    end
  end

  context "with fallback" do
    let(:page_meta) { {} }

    it "falls back correctly" do
      expect(subject.method_name).to be_nil
    end
  end
end
```

### Test Coverage

- **Happy path** - Feature works as expected
- **Both notations** - Colon and nested syntax
- **Fallback chain** - All fallback scenarios
- **Edge cases** - Empty values, nil, missing fields
- **Type handling** - Different data types

## 📚 Documentation

### What to Document

- **README.md** - Quick start and examples
- **ENHANCEMENTS.md** - Detailed feature documentation
- **Code comments** - Method documentation
- **Examples** - Real-world use cases

### Documentation Style

- Clear and concise
- Include code examples
- Show both simple and complex usage
- Explain "why" not just "what"
- Link to relevant specs (Open Graph, Twitter Card)

## 🔄 Release Process

### Versioning

This fork follows the official jekyll-seo-tag version with enhancements:
- Base version: 2.8.0
- Fork enhancements are documented but don't change version

### Changelog

Update ENHANCEMENTS.md with:
- Date of change
- Feature description
- Examples
- Migration notes if needed

## 🙋 Questions?

- **Feature questions**: Open an issue
- **Implementation help**: Open a discussion
- **Bug reports**: Open an issue with details
- **General Jekyll questions**: See [Jekyll docs](https://jekyllrb.com/docs/)

## 🤝 Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Help others learn
- Follow open source best practices

## 📧 Contact

- **GitHub Issues**: [Open an issue](https://github.com/Bhoj-karki/jekyll-seo-tag/issues)
- **Email**: kathyonu@gmail.com (for sensitive matters)

## 🙏 Thank You!

Your contributions make this plugin better for everyone. Whether it's:
- Reporting bugs
- Suggesting features
- Writing documentation
- Submitting code
- Helping others

Every contribution is valued and appreciated!

---

**Happy Contributing!** 🎉
