# SkunkCRM

Manage CRM contacts, activities, deals, and campaigns via WP-CLI.

## When to Use

Use this skill when:
- Managing contacts in a WordPress site with SkunkCRM
- Adding notes or activities to contact records
- Managing sales pipeline deals (Pro)
- Triggering automation workflows (Pro)
- Checking email campaign performance (Pro)

## Commands

### Contacts (Free + Pro)

```bash
# List contacts with filters
wp skunkcrm contacts list
wp skunkcrm contacts list --status=lead --source=form
wp skunkcrm contacts list --tag=vip --limit=20
wp skunkcrm contacts list --search="john" --format=json

# Get a specific contact
wp skunkcrm contacts get 42
wp skunkcrm contacts get 42 --format=json

# Create a contact
wp skunkcrm contacts create --email=john@example.com --name="John Doe"
wp skunkcrm contacts create --email=jane@example.com --status=customer --tags=vip,newsletter

# Update a contact
wp skunkcrm contacts update 42 --status=customer
wp skunkcrm contacts update 42 --add-tags=vip,priority
wp skunkcrm contacts update 42 --remove-tags=cold-lead
```

### Activities (Free + Pro)

```bash
# List activities
wp skunkcrm activities list
wp skunkcrm activities list --contact_id=42
wp skunkcrm activities list --type=email --limit=20

# Add a note to a contact
wp skunkcrm activities add-note 42 "Called and left voicemail"
wp skunkcrm activities add-note 42 "Meeting scheduled for Tuesday"
```

### Deals (Pro Only)

```bash
# List deals
wp skunkcrm-pro deals list
wp skunkcrm-pro deals list --stage=negotiation
wp skunkcrm-pro deals list --status=open --format=json

# Create a deal
wp skunkcrm-pro deals create --contact_id=42 --title="Enterprise Contract" --value=50000
wp skunkcrm-pro deals create --contact_id=42 --title="Support Plan" --value=1200 --stage=proposal

# Update a deal
wp skunkcrm-pro deals update 123 --stage=negotiation
wp skunkcrm-pro deals update 123 --status=won
wp skunkcrm-pro deals update 123 --value=55000 --probability=80
```

### Automations (Pro Only)

```bash
# List automations
wp skunkcrm-pro automations list
wp skunkcrm-pro automations list --status=active

# Run an automation for a contact
wp skunkcrm-pro automations run 5 42
```

### Campaigns (Pro Only)

```bash
# List email campaigns
wp skunkcrm-pro campaigns list
wp skunkcrm-pro campaigns list --status=sent
wp skunkcrm-pro campaigns list --type=sequence

# Get campaign stats
wp skunkcrm-pro campaigns stats 123
```

### Reports (Pro Only)

```bash
# Generate reports
wp skunkcrm-pro reports generate contacts --period=month
wp skunkcrm-pro reports generate deals --period=quarter --format=json
wp skunkcrm-pro reports generate campaigns --period=week
```

## Output Formats

All list commands support `--format` with options:
- `table` (default) - Human-readable table
- `json` - JSON output for parsing
- `csv` - CSV for spreadsheets
- `yaml` - YAML format

## Common Workflows

### Add a new lead and tag them
```bash
# Create contact
wp skunkcrm contacts create --email=new@lead.com --name="New Lead" --source=manual --porcelain
# Returns: 123

# Add tags
wp skunkcrm contacts update 123 --add-tags=hot-lead,follow-up

# Add note
wp skunkcrm activities add-note 123 "Inbound inquiry about enterprise plan"
```

### Move lead through pipeline (Pro)
```bash
# Create deal
wp skunkcrm-pro deals create --contact_id=123 --title="Enterprise Deal" --value=25000 --stage=qualified

# Move through stages
wp skunkcrm-pro deals update 456 --stage=proposal
wp skunkcrm-pro deals update 456 --stage=negotiation --probability=60
wp skunkcrm-pro deals update 456 --status=won
```

### Check campaign performance (Pro)
```bash
# List recent campaigns
wp skunkcrm-pro campaigns list --status=sent --limit=5

# Get detailed stats
wp skunkcrm-pro campaigns stats 789 --format=json
```

## Tips

- Use `--porcelain` flag when scripting to get just IDs
- Pipe JSON output to `jq` for advanced filtering
- Combine with `studio wp` for local WordPress Studio sites
- Use `--path=/path/to/wordpress` for non-default WordPress installs
