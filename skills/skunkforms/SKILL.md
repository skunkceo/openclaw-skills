# SkunkForms

Manage forms and submissions via WP-CLI.

## Installation

```bash
# Install the WordPress plugin (via Skunk CLI)
skunk install plugin skunkforms

# For Pro features
skunk install plugin skunkforms-pro --license=YOUR_LICENSE_KEY

# Or via WP-CLI directly
wp plugin install "https://skunkglobal.com/api/plugin-updates/download?slug=skunkforms" --activate

# Or via WordPress Studio
studio wp plugin install "https://skunkglobal.com/api/plugin-updates/download?slug=skunkforms" --activate
```

## When to Use

Use this skill when:
- Viewing or managing forms on a WordPress site with SkunkForms
- Retrieving form submissions
- Exporting submission data
- Creating or modifying forms programmatically (Pro)

## Commands

### List Forms (Free + Pro)

```bash
# List all forms
wp skunkforms list
wp skunkforms list --status=publish
wp skunkforms list --format=json
```

### Get Form Details (Free + Pro)

```bash
# Get a specific form's configuration
wp skunkforms get 42
wp skunkforms get 42 --format=json
```

### View Submissions (Free + Pro)

```bash
# List submissions
wp skunkforms submissions
wp skunkforms submissions --form_id=42
wp skunkforms submissions --status=new --limit=20
wp skunkforms submissions --date_after=2026-01-01 --format=json

# Get a specific submission
wp skunkforms submission 123
wp skunkforms submission 123 --format=json
```

### Export Submissions (Free + Pro)

```bash
# Export to CSV
wp skunkforms export 42 --output=submissions.csv

# Export to JSON
wp skunkforms export 42 --format=json --output=submissions.json

# Export with date filter
wp skunkforms export 42 --date_after=2026-01-01 --output=january.csv
```

### Create Forms (Pro Only)

```bash
# Create a simple form
wp skunkforms-pro create --title="Contact Form"

# Create with fields
wp skunkforms-pro create --title="Survey" --fields='[
  {"type":"text","label":"Name","required":true},
  {"type":"email","label":"Email","required":true},
  {"type":"textarea","label":"Message"}
]'

# Create and publish
wp skunkforms-pro create --title="Newsletter Signup" --status=publish
```

### Update Forms (Pro Only)

```bash
# Update title
wp skunkforms-pro update 42 --title="New Form Title"

# Change status
wp skunkforms-pro update 42 --status=publish

# Add a field
wp skunkforms-pro update 42 --add-field='{"type":"checkbox","label":"Subscribe to newsletter"}'
```

### Delete Forms (Pro Only)

```bash
# Move to trash
wp skunkforms-pro delete 42

# Permanently delete
wp skunkforms-pro delete 42 --force
```

### Duplicate Forms (Pro Only)

```bash
# Duplicate a form
wp skunkforms-pro duplicate 42
wp skunkforms-pro duplicate 42 --title="Contact Form v2"
```

### Webhooks (Pro Only)

```bash
# Trigger webhook for a submission
wp skunkforms-pro webhook 42 123

# Use custom webhook URL
wp skunkforms-pro webhook 42 123 --url=https://example.com/webhook
```

## Output Formats

All list commands support `--format` with options:
- `table` (default) - Human-readable table
- `json` - JSON output for parsing
- `csv` - CSV for spreadsheets
- `yaml` - YAML format

## Common Workflows

### View recent submissions
```bash
# Get submissions from last week
wp skunkforms submissions --form_id=42 --date_after=$(date -d '7 days ago' +%Y-%m-%d) --format=json
```

### Create a contact form (Pro)
```bash
wp skunkforms-pro create --title="Contact Us" --status=publish --fields='[
  {"type":"text","label":"Name","required":true},
  {"type":"email","label":"Email","required":true},
  {"type":"tel","label":"Phone"},
  {"type":"textarea","label":"Message","required":true}
]'
```

### Export and backup all submissions
```bash
# Export all forms' submissions
for form_id in $(wp skunkforms list --format=ids); do
  wp skunkforms export $form_id --output="form-${form_id}-submissions.csv"
done
```

## Tips

- Use `--porcelain` flag when scripting to get just IDs
- Field JSON must be valid JSON - use single quotes around the whole thing
- Combine with `studio wp` for local WordPress Studio sites
- Use `--path=/path/to/wordpress` for non-default WordPress installs
