# WordPress Studio

Manage local WordPress sites using WordPress Studio CLI.

## What It Does

- List and manage local WordPress Studio sites
- Run WP-CLI commands through Studio
- Create and update preview sites for sharing
- Start, stop, and configure local sites

## Installation

```bash
clawhub install wordpress-studio
```

## Requirements

- **WordPress Studio** installed ([download](https://developer.wordpress.org/studio))
- **Studio CLI** enabled (Settings → Enable Studio CLI)

## Usage

Ask naturally:

- "List my WordPress Studio sites"
- "Show plugins on my local site at ~/Studio/my-project"
- "Create a draft post on my local WordPress"
- "Start my Studio site"
- "Create a preview URL I can share"

## Why Studio CLI?

WordPress Studio includes its own WP-CLI that's pre-configured for each site. Using `studio wp` instead of raw `wp` ensures:

- Correct PHP version for each site
- Proper database connections
- No path/config conflicts

## Tags

`wordpress` `studio` `local-dev` `wp-cli`

## Author

[Skunk Global](https://skunkglobal.com)
