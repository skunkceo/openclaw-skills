# WP Backup

Create and manage WordPress site backups.

## What It Does

- Create full site backups (files + database)
- Schedule automated backups
- Export database snapshots
- Restore from backup
- Upload backups to remote storage

## Installation

```bash
skunk install wp-backup
```

## Requirements

- **WP-CLI** installed on the WordPress server
- Write access to backup directory
- (Optional) Remote storage credentials (S3, etc.)

## Usage

Ask naturally:

- "Backup the WordPress site now"
- "Export just the database"
- "List recent backups"
- "Restore from yesterday's backup"
- "Schedule daily backups at 3am"

## Backup Location

By default, backups are stored in `wp-content/backups/`. Configure a different path or remote storage in your OpenClaw config.

## Tags

`wordpress` `backup` `database` `disaster-recovery` `wp-cli`

## Author

[Skunk Global](https://skunkglobal.com)
