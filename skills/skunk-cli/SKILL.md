# Skunk CLI

Install and manage Skunk Global AI skills and WordPress plugins.

## When to Use

Use this skill when:
- Installing Skunk WordPress plugins (SkunkCRM, SkunkForms, SkunkPages)
- Installing AI skills for yourself or other agents
- Setting up a new WordPress + Skunk development environment
- Updating the Skunk toolkit

## Installation

```bash
npm install -g @skunkceo/cli
```

## Commands

### Install WordPress Plugins

```bash
# Install free versions
skunk install plugin skunkcrm
skunk install plugin skunkforms
skunk install plugin skunkpages

# Install Pro versions (requires license)
skunk install plugin skunkcrm-pro --license=XXXX-XXXX-XXXX
skunk install plugin skunkforms-pro --license=XXXX-XXXX-XXXX
skunk install plugin skunkpages-pro --license=XXXX-XXXX-XXXX
```

The plugin install command:
- Detects WP-CLI or WordPress Studio automatically
- Downloads from official Skunk servers
- Activates the plugin after install

### Install AI Skills

```bash
# Install individual skills
skunk install skill skunkcrm
skunk install skill skunkforms
skunk install skill skunkpages
skunk install skill wordpress-studio
skunk install skill woocommerce

# List installed skills
skunk list

# List available skills
skunk available

# Remove a skill
skunk remove skill skunkforms
```

### List Available Plugins

```bash
skunk plugins
```

Output:
- skunkcrm / skunkcrm-pro
- skunkforms / skunkforms-pro
- skunkpages / skunkpages-pro

### Update CLI and Skills

```bash
skunk update
```

This updates the CLI to the latest version and refreshes all installed skills.

### Interactive Setup

```bash
skunk setup
```

Guided wizard that:
1. Checks Node.js, OpenClaw, WordPress Studio
2. Installs core AI skills
3. Provides next steps

## Skills vs Plugins

**Skills** teach AI assistants (like you) how to use Skunk products. They're documentation and context — installed to `~/.openclaw/skills/`.

**Plugins** are the actual WordPress plugins that run on WordPress sites. They provide the functionality.

For full capability, install both:
```bash
# Install the plugin on the WordPress site
skunk install plugin skunkforms

# Install the skill so you know how to use it
skunk install skill skunkforms
```

## Common Workflows

### Set up a new WordPress site with Skunk stack

```bash
# Create site in WordPress Studio
studio create my-site

# Install Skunk plugins
skunk install plugin skunkcrm
skunk install plugin skunkforms

# Or if you have Pro licenses
skunk install plugin skunkcrm-pro --license=XXXX
skunk install plugin skunkforms-pro --license=XXXX
```

### Upgrade from Free to Pro

```bash
# Install Pro version (replaces Free)
skunk install plugin skunkforms-pro --license=XXXX
```

### Check what's installed

```bash
# AI skills
skunk list

# WordPress plugins (via WP-CLI)
wp plugin list
# or
studio wp plugin list
```

## Requirements

- Node.js 18+
- For plugin installation: WP-CLI or WordPress Studio

## Links

- [Skunk Global](https://skunkglobal.com)
- [OpenClaw WordPress Guide](https://skunkglobal.com/guides/openclaw-wordpress)
- [SkunkCRM](https://skunkcrm.com)
- [SkunkForms](https://skunkforms.com)
- [SkunkPages](https://skunkpages.com)
