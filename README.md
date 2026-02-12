# OpenClaw Skills Directory

Curated, Skunk-approved skills for OpenClaw AI agents. Every skill in this repository has been reviewed for quality and security.

## Installation

Install any skill with a single command:

```bash
openclaw skill install skunkceo/skill-name
```

Or manually clone and copy to your `.openclaw/workspace/skills/` directory.

## Available Skills

### WordPress
- **wp-site-health** — Check plugin updates, security status, and performance metrics
- **wp-content-manager** — Create, edit, and schedule posts and pages with AI assistance
- **wp-backup** — Automated database and file backups with cloud storage support
- **woocommerce-manager** — Manage products, orders, and inventory

### SEO
- **seo-analyzer** — Analyze pages for SEO issues and get optimization recommendations
- **keyword-research** — Find keyword opportunities with search volume data
- **gsc-reporter** — Pull Google Search Console data and generate reports

### Social Media
- **social-scheduler** — Schedule posts across multiple platforms
- **twitter-monitor** — Monitor mentions, hashtags, and competitors

### Productivity
- **email-manager** — Read, organize, and draft emails
- **calendar-sync** — Manage events and scheduling
- **notion-connector** — Read and write Notion pages and databases

### APIs & Integrations
- **stripe-manager** — Manage payments, subscriptions, and customers
- **slack-bot** — Send messages and automate Slack workflows
- **webhook-handler** — Receive and process webhooks

### Developer Tools
- **github-manager** — Manage repos, PRs, issues, and actions
- **docker-manager** — Build, run, and manage containers
- **db-query** — Execute SQL queries against databases

## Skill Structure

Each skill follows this structure:

```
skills/skill-name/
├── SKILL.md          # Main skill documentation and instructions
├── scripts/          # Executable scripts (optional)
│   └── main.sh
├── prompts/          # Prompt templates (optional)
│   └── system.md
└── config.json       # Skill metadata and configuration
```

## Creating Your Own Skills

1. Fork this repository
2. Create a new folder in `skills/` with your skill name
3. Add a `SKILL.md` with instructions for the AI agent
4. Add a `config.json` with metadata
5. Submit a pull request

### config.json Template

```json
{
  "name": "my-skill",
  "version": "1.0.0",
  "description": "What this skill does",
  "author": "Your Name",
  "tags": ["category", "keywords"],
  "requires": []
}
```

## Browse Online

View the full directory with search and filters at:
**https://skunkglobal.com/skills**

## License

MIT License - feel free to use, modify, and distribute.

---

Built by [Skunk Global](https://skunkglobal.com) for the OpenClaw community.
