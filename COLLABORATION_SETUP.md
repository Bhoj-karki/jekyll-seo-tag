# Collaboration Setup Guide

Welcome bishisht! This guide will help you get started working on this enhanced Jekyll SEO Tag plugin.

## 🚀 Quick Start for Collaborators

### 1. Clone the Repository

```bash
git clone https://github.com/Bhoj-karki/jekyll-seo-tag.git
cd jekyll-seo-tag
```

### 2. Install Dependencies

```bash
# Install Ruby gems
bundle install

# Note: If eventmachine fails on Apple Silicon, that's OK
# Tests can still run, just the dev server won't work
bundle install --jobs 4 || echo "Some dependencies may have failed - that's expected"
```

### 3. Verify Setup

```bash
# Run tests to ensure everything works
bundle exec rspec

# Build the gem
gem build jekyll-seo-tag.gemspec

# Should output: Successfully built RubyGem - jekyll-seo-tag-2.8.0.gem
```

## 📁 Repository Structure

```
jekyll-seo-tag/
├── lib/
│   ├── jekyll-seo-tag.rb              # Main plugin file
│   ├── template.html                   # SEO tags template (ENHANCED ✨)
│   └── jekyll-seo-tag/
│       ├── drop.rb                     # Data handling (ENHANCED ✨)
│       ├── json_ld.rb                  # JSON-LD structured data
│       ├── author_drop.rb              # Author data
│       ├── image_drop.rb               # Image data
│       └── ...
├── spec/
│   ├── jekyll_seo_tag/
│   │   └── drop_spec.rb                # Tests (ENHANCED ✨)
│   └── ...
├── docs/                               # Documentation examples
├── README.md                           # Main documentation (NEW ✨)
├── ENHANCEMENTS.md                     # Feature documentation (NEW ✨)
├── CONTRIBUTING.md                     # How to contribute (NEW ✨)
├── COLLABORATION_SETUP.md              # This file (NEW ✨)
└── jekyll-seo-tag.gemspec              # Gem specification
```

**✨ = Recently enhanced/created files**

## 🔧 Development Workflow

### Making Changes

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/bug-description
   ```

2. **Make your changes**
   - Edit code in `lib/`
   - Add tests in `spec/`
   - Update documentation

3. **Test your changes**
   ```bash
   bundle exec rspec
   ```

4. **Commit with descriptive message**
   ```bash
   git add -A
   git commit -m "feat: Add new feature description"
   # or
   git commit -m "fix: Fix bug description"
   ```

5. **Push to GitHub**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create Pull Request**
   - Go to GitHub repository
   - Click "Pull requests" → "New pull request"
   - Select your branch
   - Fill in description
   - Request review

### Commit Message Convention

Use conventional commits format:

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `test:` - Test additions/changes
- `refactor:` - Code refactoring
- `style:` - Code style changes
- `chore:` - Maintenance tasks

**Examples**:
```
feat: Add support for og:locale:alternate
fix: Correct twitter:card fallback logic
docs: Update README.md with new examples
test: Add tests for nested notation support
```

## 🎯 Current Enhancement Status

### What's Been Enhanced (Last Commit: 1155619)

1. ✅ **Platform-Specific Titles** - Different titles per platform
2. ✅ **Platform-Specific Descriptions** - Optimized per platform
3. ✅ **Audio Metadata** - og:audio support
4. ✅ **Video Metadata** - og:video support
5. ✅ **Explicit Type Control** - og:type override
6. ✅ **Robots Meta Tag** - Per-page control
7. ✅ **Twitter Customization** - Full twitter:* fields
8. ✅ **Flexible Front Matter** - Both notations

### Enhanced Files

| File | What Was Enhanced |
|------|-------------------|
| `lib/jekyll-seo-tag/drop.rb` | 11 new methods, 2 enhanced methods, comprehensive comments |
| `lib/template.html` | Audio/video sections, robots tag, enhanced Twitter Card |
| `spec/jekyll_seo_tag/drop_spec.rb` | 15+ new test contexts |

## 🧪 Testing

### Run All Tests
```bash
bundle exec rspec
```

### Run Specific Test File
```bash
bundle exec rspec spec/jekyll_seo_tag/drop_spec.rb
```

### Run Specific Test Context
```bash
bundle exec rspec spec/jekyll_seo_tag/drop_spec.rb -e "og_title"
```

### Test with Verbose Output
```bash
bundle exec rspec --format documentation
```

### Writing New Tests

Follow the pattern in `drop_spec.rb`:

```ruby
context "your_feature" do
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

## 📚 Understanding the Code

### Key Classes

1. **Jekyll::SeoTag::Drop** (`lib/jekyll-seo-tag/drop.rb`)
   - Handles all data processing
   - Contains methods for titles, descriptions, metadata
   - Our enhancements are here

2. **Template** (`lib/template.html`)
   - Liquid template for generated tags
   - Outputs HTML meta tags
   - Our enhancements for audio/video/twitter here

3. **Tests** (`spec/jekyll_seo_tag/drop_spec.rb`)
   - RSpec tests
   - Test all methods and fallback chains

### Enhanced Methods (Your Work)

**In `drop.rb`**:
```ruby
# New methods added
og_title          # Open Graph title
og_description    # Open Graph description
twitter_title     # Twitter Card title
twitter_description # Twitter Card description
twitter_card      # Twitter Card type
twitter_image     # Twitter Card image
robots            # Robots directive
audio             # Audio metadata hash
video             # Video metadata hash

# Enhanced methods
page_title        # Now supports explicit page_title field
type              # Now supports og:type override
```

### How Data Flows

```
Front Matter → Drop Methods → Template → HTML Output

Example:
og:title: "My Title"
    ↓
subject.og_title
    ↓
<meta property="og:title" content="My Title" />
```

## 🔍 Debugging Tips

### View Generated Tags

```bash
# Build test site
cd /path/to/test/jekyll/site
bundle exec jekyll build

# View generated tags
cat _site/page.html | grep -A 30 "Jekyll SEO tag"
```

### Test in IRB

```bash
bundle exec irb

require './lib/jekyll-seo-tag'
# Test individual methods
```

### Enable Debug Logging

In tests:
```ruby
Jekyll.logger.log_level = :debug
```

## 📖 Documentation to Read

**Priority Order**:

1. **README.md** - Start here for overview
2. **ENHANCEMENTS.md** - Deep dive into features
3. **CONTRIBUTING.md** - Contribution guidelines
4. **Code Comments** - Inline documentation
5. **Tests** - Examples of usage

## 🤝 Working Together

### Communication

- **GitHub Issues** - Bug reports, feature requests
- **GitHub Discussions** - Questions, ideas
- **Pull Requests** - Code reviews
- **Email** - kathyonu@gmail.com (for urgent matters)

### Code Review Process

1. **Submit PR** with clear description
2. **Wait for review** (aim for 24-48 hours)
3. **Address feedback** if requested
4. **Get approval** from maintainer
5. **Merge** to master

### What to Work On

**Good First Issues**:
- Add more test coverage
- Improve documentation
- Add examples to ENHANCEMENTS.md
- Fix typos or unclear docs

**Feature Ideas**:
- Support for more social platforms
- Additional metadata fields
- Performance optimizations
- Better error messages

**Check**:
- GitHub Issues labeled "good first issue"
- GitHub Issues labeled "help wanted"

## 🎨 Code Style

### Ruby Style

```ruby
# Use 2 spaces for indentation
def method_name
  if condition
    do_something
  end
end

# Snake_case for methods and variables
def calculate_total
  item_count = 10
end

# Meaningful names
def og_title  # Good
  # ...
end

def gt  # Bad - unclear
  # ...
end
```

### Documentation Style

```ruby
# Full documentation for public methods
# Include description, parameters, return value, examples
#
# Returns the Open Graph title
#
# Priority:
#   1. page["og:title"]
#   2. page_title
#
# Returns formatted string or nil
def og_title
  # implementation
end
```

## 🛠️ Useful Commands

### Git Commands
```bash
# Update your fork
git fetch origin
git merge origin/master

# View commit history
git log --oneline

# See what changed
git diff

# Undo uncommitted changes
git checkout -- file.rb
```

### Bundle Commands
```bash
# Install dependencies
bundle install

# Update gems
bundle update

# Check gem versions
bundle list
```

### Gem Commands
```bash
# Build gem
gem build jekyll-seo-tag.gemspec

# Install locally built gem
gem install jekyll-seo-tag-2.8.0.gem
```

## 🐛 Common Issues

### Issue: Bundle install fails (eventmachine)

**Solution**: This is expected on Apple Silicon
```bash
# It's OK, tests still work
bundle install || true

# Or skip problematic gems
bundle config set without 'development'
bundle install
```

### Issue: Tests fail

**Solution**: Ensure you're on latest master
```bash
git checkout master
git pull origin master
bundle install
bundle exec rspec
```

### Issue: Syntax errors

**Solution**: Check Ruby version
```bash
ruby --version  # Should be 2.5.0 or higher
```

## 📞 Getting Help

### If You're Stuck

1. **Check documentation** - README.md, ENHANCEMENTS.md
2. **Read code comments** - Methods are well documented
3. **Look at tests** - See how features are used
4. **Search issues** - Someone may have asked already
5. **Open a discussion** - Ask on GitHub
6. **Email maintainer** - kathyonu@gmail.com

### If You Find a Bug

1. **Check if already reported** - Search issues
2. **Create minimal reproduction** - Simplest example
3. **Open issue** with:
   - Clear description
   - Front matter example
   - Expected vs actual output
   - Ruby/Jekyll versions

## 🎯 Next Steps

### For bishisht

1. **Clone repository** ✅
2. **Install dependencies** ✅
3. **Run tests** to verify ✅
4. **Read documentation**:
   - README.md
   - ENHANCEMENTS.md
   - Code comments in drop.rb
5. **Try making a small change**
6. **Submit your first PR**

### Getting Started Tasks

**Easy**:
- [ ] Fix a typo in documentation
- [ ] Add an example to ENHANCEMENTS.md
- [ ] Improve a code comment
- [ ] Add a test case

**Medium**:
- [ ] Add support for og:locale:alternate
- [ ] Improve error handling
- [ ] Add validation for URLs
- [ ] Optimize performance

**Advanced**:
- [ ] Add new platform support (Pinterest, etc.)
- [ ] Implement caching
- [ ] Add schema.org enhancements

## 📋 Collaboration Checklist

Before starting work:
- [ ] Repository cloned
- [ ] Dependencies installed
- [ ] Tests pass
- [ ] Documentation read
- [ ] Feature branch created

Before submitting PR:
- [ ] Code tested locally
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] Commit messages clear
- [ ] No conflicts with master
- [ ] Ready for review

## 🎉 Welcome!

You're now set up to collaborate on the enhanced Jekyll SEO Tag plugin!

**Questions?** Open a GitHub discussion or email kathyonu@gmail.com

**Ready to code?** Pick an issue and submit a PR!

**Happy coding!** 🚀

---

*Last Updated: 2025-02-13*
*Repository: https://github.com/Bhoj-karki/jekyll-seo-tag*
