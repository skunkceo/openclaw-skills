# WordPress Site Health

Check plugin updates, security status, and performance metrics for WordPress sites.

## Usage

When asked to check site health, audit a WordPress site, or monitor for issues:

1. Connect via SSH or WP-CLI to the target site
2. Run health checks using the commands below
3. Report findings with actionable recommendations

## Commands

### Check Plugin Updates
```bash
wp plugin list --update=available --format=table
```

### Check Core Updates
```bash
wp core check-update
```

### Check Theme Updates
```bash
wp theme list --update=available --format=table
```

### Site Health Status
```bash
wp site health status
```

### Database Optimization Check
```bash
wp db check
wp db optimize --dry-run
```

### Check PHP Version
```bash
wp eval "echo 'PHP ' . PHP_VERSION;"
```

### List Active Plugins
```bash
wp plugin list --status=active --format=table
```

### Check for Known Vulnerabilities
Query the WPScan API or check plugin changelogs for security updates.

## Report Format

When reporting findings, use this structure:

**Site Health Report: [domain]**

**Critical Issues**
- [List any security vulnerabilities or major problems]

**Warnings**
- [Outdated plugins/themes, performance concerns]

**Passed Checks**
- [What's healthy and up to date]

**Recommendations**
1. [Prioritized action items]

## Configuration

Set `WP_CLI_SSH` in your environment for remote site access:
```bash
export WP_CLI_SSH_HOST="user@server.com"
export WP_CLI_SSH_PATH="/var/www/html"
```

## Requirements

- WP-CLI installed locally or on target server
- SSH access to remote WordPress sites
- Database access for optimization checks
