# Notion Connector

Read and write to Notion pages, databases, and blocks.

## What It Does

- Create and update pages
- Query and update databases
- Manage blocks and content
- Search across workspace
- Sync content bidirectionally

## Installation

```bash
clawhub install notion-connector
```

## Requirements

- Notion API key (integration token)
- Integration added to relevant pages/databases

## Setup

1. Create a Notion integration at notion.so/my-integrations
2. Copy the integration token
3. Add to OpenClaw config or environment:
   ```bash
   export NOTION_API_KEY="secret_xxx"
   ```
4. Share pages/databases with your integration

## Usage

Ask naturally:

- "Add a new task to my Notion todo database"
- "Find all pages mentioning SkunkCRM"
- "Update the status of project X to Done"
- "Create a new page in the Docs section"
- "List items in my content calendar"

## Tags

`notion` `productivity` `database` `wiki` `documentation`

## Author

[Skunk Global](https://skunkglobal.com)
