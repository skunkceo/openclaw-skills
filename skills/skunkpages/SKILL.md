# SkunkPages

Manage landing pages and templates via WP-CLI.

## Installation

```bash
# Install the WordPress plugin (via Skunk CLI)
skunk install plugin skunkpages

# For Pro features (create, duplicate, schedule)
skunk install plugin skunkpages-pro --license=YOUR_LICENSE_KEY

# Or via WP-CLI directly
wp plugin install "https://skunkglobal.com/api/plugin-updates/download?slug=skunkpages" --activate

# Or via WordPress Studio
studio wp plugin install "https://skunkglobal.com/api/plugin-updates/download?slug=skunkpages" --activate
```

## When to Use

Use this skill when:
- Managing landing pages on a WordPress site with SkunkPages
- Browsing available templates
- Creating or modifying landing pages programmatically (Pro)
- Publishing or scheduling pages (Pro)

## Commands

### List Pages (Free + Pro)

```bash
# List all landing pages
wp skunkpages list
wp skunkpages list --status=publish
wp skunkpages list --format=json
```

### Get Page Details (Free + Pro)

```bash
# Get a specific page's configuration
wp skunkpages get 42
wp skunkpages get 42 --format=json
```

### Browse Templates (Free + Pro)

```bash
# List all templates
wp skunkpages templates
wp skunkpages templates --category=sales
wp skunkpages templates --category=webinar --format=json
```

### Create Pages (Pro Only)

```bash
# Create a blank page
wp skunkpages-pro create --title="My Landing Page"

# Create from template
wp skunkpages-pro create --title="Sales Page" --template=sales-basic

# Create and publish
wp skunkpages-pro create --title="Webinar Registration" --template=webinar --status=publish
```

### Update Pages (Pro Only)

```bash
# Update title
wp skunkpages-pro update 42 --title="New Page Title"

# Change status
wp skunkpages-pro update 42 --status=draft

# Apply different template
wp skunkpages-pro update 42 --template=minimal
```

### Delete Pages (Pro Only)

```bash
# Move to trash
wp skunkpages-pro delete 42

# Permanently delete
wp skunkpages-pro delete 42 --force
```

### Duplicate Pages (Pro Only)

```bash
# Duplicate a page
wp skunkpages-pro duplicate 42
wp skunkpages-pro duplicate 42 --title="Landing Page v2"
```

### Publish Pages (Pro Only)

```bash
# Publish immediately
wp skunkpages-pro publish 42

# Schedule for future
wp skunkpages-pro publish 42 --schedule="2026-03-01 09:00:00"
```

## Output Formats

All list commands support `--format` with options:
- `table` (default) - Human-readable table
- `json` - JSON output for parsing
- `csv` - CSV for spreadsheets
- `yaml` - YAML format

## Common Workflows

### Create a sales page from template (Pro)
```bash
# List sales templates
wp skunkpages templates --category=sales

# Create from template
wp skunkpages-pro create --title="Black Friday Sale" --template=sales-countdown --porcelain
# Returns: 123

# Get the URL
wp post get 123 --field=guid
```

### Duplicate and modify for A/B testing (Pro)
```bash
# Duplicate original
wp skunkpages-pro duplicate 42 --title="Landing Page - Variant B" --porcelain
# Returns: 43

# Both pages are drafts - edit variant B, then publish both
wp skunkpages-pro publish 42
wp skunkpages-pro publish 43
```

### Schedule a campaign page (Pro)
```bash
# Create page
wp skunkpages-pro create --title="New Year Sale" --template=sales-countdown --porcelain
# Returns: 44

# Schedule for New Year's Day
wp skunkpages-pro publish 44 --schedule="2027-01-01 00:00:00"
```

### Batch export all landing pages
```bash
# Get all page IDs and content
for page_id in $(wp skunkpages list --format=ids); do
  wp skunkpages get $page_id --format=json > "page-${page_id}.json"
done
```

## Tips

- Use `--porcelain` flag when scripting to get just IDs
- Template IDs are shown in `wp skunkpages templates` output
- Combine with `studio wp` for local WordPress Studio sites
- Use `--path=/path/to/wordpress` for non-default WordPress installs
