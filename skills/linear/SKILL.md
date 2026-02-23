# Linear Skill

Interact with Linear project management. Create, update, list, and manage issues across teams and projects.

## Setup

Store your Linear API key (Personal API keys at linear.app/settings/api):

```json
// credentials/linear-api.json
{
  "api_key": "lin_api_YOUR_KEY_HERE"
}
```

Get your team IDs by running:

```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Authorization: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query":"{ teams { nodes { id name key } } }"}' | jq '.data.teams.nodes'
```

## Helper Script

Use `scripts/linear.sh` for common operations:

```bash
# List open issues
./skills/linear/scripts/linear.sh list

# List issues for a specific team
./skills/linear/scripts/linear.sh list --team MYTEAM

# Create an issue
./skills/linear/scripts/linear.sh create --team MYTEAM --title "Fix bug" --priority 2

# Get issue details
./skills/linear/scripts/linear.sh get TEAM-123

# Update issue state
./skills/linear/scripts/linear.sh update TEAM-123 --state "In Progress"
```

Set `CREDS_FILE` env var if your credentials are in a non-default location.

## API Reference

Linear uses GraphQL. Base URL: `https://api.linear.app/graphql`

All requests require the `Authorization` header with your API key (no `Bearer` prefix needed).

### List Issues

```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "{ issues(first: 20, orderBy: updatedAt) { nodes { id identifier title state { name } priority labels { nodes { name } } } } }"}'
```

### Filter by Team

```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "{ team(id: \"YOUR_TEAM_ID\") { issues(first: 20) { nodes { identifier title state { name } } } } }"}'
```

### Filter by State Type

```bash
# Active issues (todo + in progress)
curl -s -X POST https://api.linear.app/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "{ issues(first: 50, filter: { state: { type: { in: [\"unstarted\", \"started\"] } } }) { nodes { identifier title state { name } team { key } } } }"}'
```

State types: `backlog`, `unstarted`, `started`, `completed`, `cancelled`

### Create Issue

```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{
    "query": "mutation CreateIssue($input: IssueCreateInput!) { issueCreate(input: $input) { success issue { id identifier title url } } }",
    "variables": {
      "input": {
        "teamId": "YOUR_TEAM_ID",
        "title": "Issue title",
        "description": "Issue description in **markdown**",
        "priority": 3
      }
    }
  }'
```

Priority: `1` = Urgent, `2` = High, `3` = Medium, `4` = Low, `0` = None

### Update Issue State

```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{
    "query": "mutation UpdateIssue($id: String!, $input: IssueUpdateInput!) { issueUpdate(id: $id, input: $input) { success issue { identifier state { name } } } }",
    "variables": {
      "id": "ISSUE_UUID",
      "input": { "stateId": "STATE_UUID" }
    }
  }'
```

### Get Issue by Identifier

```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "{ issue(id: \"TEAM-123\") { id identifier title description state { name } priority comments { nodes { body user { name } } } } }"}'
```

### Add Comment

```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{
    "query": "mutation CreateComment($input: CommentCreateInput!) { commentCreate(input: $input) { success comment { id body } } }",
    "variables": {
      "input": {
        "issueId": "ISSUE_UUID",
        "body": "Comment text in **markdown**"
      }
    }
  }'
```

### Get Workflow States for a Team

```bash
curl -s -X POST https://api.linear.app/graphql \
  -H "Content-Type: application/json" \
  -H "Authorization: $LINEAR_API_KEY" \
  -d '{"query": "{ team(id: \"YOUR_TEAM_ID\") { states { nodes { id name type } } } }"}'
```

## Useful Filters

```
# High priority only
filter: { priority: { lte: 2 } }

# By label name
filter: { labels: { name: { eq: "bug" } } }

# Created in last 7 days
filter: { createdAt: { gt: "2024-01-01T00:00:00Z" } }

# Assigned to me (get your userId first)
filter: { assignee: { id: { eq: "YOUR_USER_ID" } } }
```

## GitHub Integration

If your Linear workspace is connected to GitHub, reference issues in PR descriptions:
- `AI-123` — links the issue to the PR
- `fixes AI-123` or `closes AI-123` — auto-closes the issue on merge
