# WordPress Studio

Local WordPress development using WordPress Studio CLI.

## When to Use

Use this skill when working with local WordPress sites managed by WordPress Studio.

## Commands

### List Sites

```bash
studio site list
```

### Site Status

```bash
studio site status --path /path/to/site
```

### WP-CLI Commands

Always use `studio wp` instead of raw `wp` for Studio-managed sites:

```bash
# List plugins
studio wp plugin list --path /path/to/site

# List posts
studio wp post list --path /path/to/site

# Create post
studio wp post create --post_title="Title" --post_status=draft --path /path/to/site

# Get option
studio wp option get siteurl --path /path/to/site
```

### Site Management

```bash
# Create new site
studio site create --path /path/to/new-site

# Start site
studio site start --path /path/to/site

# Stop site
studio site stop --path /path/to/site
```

### Preview Sites (Public URLs)

```bash
# Create shareable preview
studio preview create --path /path/to/site

# List previews
studio preview list

# Update preview after changes
studio preview update <host>
```

## Important

- Always include `--path /path/to/site` unless you're in the site directory
- Use `studio wp` not `wp` directly
- Sites are typically stored in `~/Studio/` on macOS
