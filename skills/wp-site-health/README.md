# WordPress Site Health

Check plugin updates, security status, and performance metrics for your WordPress sites.

## What It Does

This skill lets your AI assistant monitor and audit WordPress sites by:
- Checking for plugin, theme, and core updates
- Running site health diagnostics  
- Analyzing database status
- Identifying potential security issues
- Generating actionable health reports

## Installation

```bash
clawhub install wp-site-health
```

That's it. The skill is automatically available on your next session.

## Requirements

- **WP-CLI** installed on the WordPress server

**Optional (for remote sites only):**
- SSH access — only needed if OpenClaw runs on a different server than WordPress
- Database access — only needed for optimization checks

If OpenClaw runs on the same server as WordPress, no extra setup needed.

## Usage

Just ask your assistant naturally:

- "Check the health of mysite.com"
- "Are there any plugin updates needed?"
- "Run a security audit on my WordPress site"
- "What's the PHP version on the server?"
- "Check for database issues"

## Example Output

When you ask for a site health check, you'll get a report like:

**Site Health Report: example.com**

**Critical Issues**
- 2 plugins have security updates available

**Warnings**  
- WordPress core update available (6.4.2 → 6.4.3)
- 3 plugins need updates

**Passed Checks**
- PHP version 8.2 (good)
- Database optimization not needed
- No inactive plugins

**Recommendations**
1. Update security-critical plugins immediately
2. Schedule core update for off-peak hours

## Tags

`wordpress` `security` `monitoring` `health-check` `wp-cli`

## Author

[Skunk Global](https://skunkglobal.com)
