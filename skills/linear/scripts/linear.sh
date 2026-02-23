#!/bin/bash
# Linear CLI helper for OpenClaw agents
# Usage: ./linear.sh <command> [options]
#
# Commands:
#   list   [--team KEY] [--state STATE] [--limit N]
#   get    IDENTIFIER (e.g. AI-123)
#   create --team KEY --title "Title" [--desc "..."] [--priority 1-4]
#   update IDENTIFIER --state "State Name" | --priority N
#   comment IDENTIFIER --body "Comment text"
#
# Auth:
#   Set CREDS_FILE to path of your linear-api.json, or set LINEAR_API_KEY directly.

set -e

API_URL="https://api.linear.app/graphql"

# ── Auth ──────────────────────────────────────────────────────────────────────
if [[ -z "$LINEAR_API_KEY" ]]; then
  CREDS_FILE="${CREDS_FILE:-$(dirname "$0")/../../../credentials/linear-api.json}"
  if [[ -f "$CREDS_FILE" ]]; then
    LINEAR_API_KEY=$(jq -r '.api_key' "$CREDS_FILE")
  else
    echo "Error: Set LINEAR_API_KEY env var or provide credentials at $CREDS_FILE" >&2
    exit 1
  fi
fi

gql() {
  curl -s -X POST "$API_URL" \
    -H "Content-Type: application/json" \
    -H "Authorization: $LINEAR_API_KEY" \
    -d "$1"
}

# ── Commands ──────────────────────────────────────────────────────────────────

cmd_list() {
  local team_filter="" state_filter="" limit=20

  while [[ $# -gt 0 ]]; do
    case $1 in
      --team)   team_filter="team: { key: { eq: \"$2\" } },"; shift 2 ;;
      --state)
        case "$2" in
          backlog)  state_filter="state: { type: { eq: \"backlog\" } }," ;;
          active)   state_filter="state: { type: { in: [\"unstarted\", \"started\"] } }," ;;
          done)     state_filter="state: { type: { eq: \"completed\" } }," ;;
          *)        state_filter="state: { name: { eq: \"$2\" } }," ;;
        esac
        shift 2 ;;
      --limit)  limit=$2; shift 2 ;;
      *)        shift ;;
    esac
  done

  local query="{
    issues(first: $limit, orderBy: updatedAt, filter: { $team_filter $state_filter }) {
      nodes { identifier title state { name } priority team { key } assignee { name } labels { nodes { name } } }
    }
  }"
  gql "{\"query\": \"$query\"}" | jq -r '.data.issues.nodes[] | "\(.identifier)\t[\(.state.name)]\t[P\(.priority)]\t\(.title)"'
}

cmd_get() {
  local id="$1"
  [[ -z "$id" ]] && { echo "Usage: get IDENTIFIER"; exit 1; }
  local query="{ issue(id: \"$id\") { id identifier title description state { name } priority team { key } assignee { name } labels { nodes { name } } comments { nodes { body createdAt user { name } } } } }"
  gql "{\"query\": \"$query\"}" | jq '.data.issue'
}

cmd_create() {
  local team="" title="" desc="" priority=3

  while [[ $# -gt 0 ]]; do
    case $1 in
      --team)     team="$2"; shift 2 ;;
      --title)    title="$2"; shift 2 ;;
      --desc)     desc="$2"; shift 2 ;;
      --priority) priority="$2"; shift 2 ;;
      *)          shift ;;
    esac
  done

  [[ -z "$team" || -z "$title" ]] && { echo "Usage: create --team KEY --title \"Title\" [--desc \"...\"] [--priority 1-4]"; exit 1; }

  # Resolve team ID from key
  local team_id
  team_id=$(gql "{\"query\": \"{ teams { nodes { id key } } }\"}" | jq -r ".data.teams.nodes[] | select(.key == \"$team\") | .id")
  [[ -z "$team_id" ]] && { echo "Error: team '$team' not found"; exit 1; }

  local vars="{\"teamId\": \"$team_id\", \"title\": \"$title\", \"priority\": $priority"
  [[ -n "$desc" ]] && vars="$vars, \"description\": \"$desc\""
  vars="$vars}"

  gql "{\"query\": \"mutation CreateIssue(\$input: IssueCreateInput!) { issueCreate(input: \$input) { success issue { identifier title url } } }\", \"variables\": {\"input\": $vars}}" \
    | jq -r 'if .data.issueCreate.success then "Created: \(.data.issueCreate.issue.identifier) — \(.data.issueCreate.issue.url)" else "Error: \(.errors // .data.issueCreate)" end'
}

cmd_update() {
  local identifier="$1"; shift
  [[ -z "$identifier" ]] && { echo "Usage: update IDENTIFIER --state \"Name\" | --priority N"; exit 1; }

  local new_state="" new_priority=""
  while [[ $# -gt 0 ]]; do
    case $1 in
      --state)    new_state="$2"; shift 2 ;;
      --priority) new_priority="$2"; shift 2 ;;
      *)          shift ;;
    esac
  done

  # Get issue UUID
  local issue_data
  issue_data=$(gql "{\"query\": \"{ issue(id: \\\"$identifier\\\") { id team { id } } }\"}")
  local issue_id team_id
  issue_id=$(echo "$issue_data" | jq -r '.data.issue.id')
  team_id=$(echo "$issue_data" | jq -r '.data.issue.team.id')

  local input_fields=""

  if [[ -n "$new_state" ]]; then
    local state_id
    state_id=$(gql "{\"query\": \"{ team(id: \\\"$team_id\\\") { states { nodes { id name } } } }\"}" \
      | jq -r ".data.team.states.nodes[] | select(.name == \"$new_state\") | .id")
    [[ -z "$state_id" ]] && { echo "Error: state '$new_state' not found in team"; exit 1; }
    input_fields="\"stateId\": \"$state_id\""
  fi

  if [[ -n "$new_priority" ]]; then
    [[ -n "$input_fields" ]] && input_fields="$input_fields, "
    input_fields="${input_fields}\"priority\": $new_priority"
  fi

  gql "{\"query\": \"mutation UpdateIssue(\$id: String!, \$input: IssueUpdateInput!) { issueUpdate(id: \$id, input: \$input) { success issue { identifier state { name } } } }\", \"variables\": {\"id\": \"$issue_id\", \"input\": {$input_fields}}}" \
    | jq -r 'if .data.issueUpdate.success then "Updated: \(.data.issueUpdate.issue.identifier) → \(.data.issueUpdate.issue.state.name)" else "Error: \(.errors // .data)" end'
}

cmd_comment() {
  local identifier="$1"; shift
  local body=""
  while [[ $# -gt 0 ]]; do
    case $1 in
      --body) body="$2"; shift 2 ;;
      *)      shift ;;
    esac
  done

  [[ -z "$identifier" || -z "$body" ]] && { echo "Usage: comment IDENTIFIER --body \"Text\""; exit 1; }

  local issue_id
  issue_id=$(gql "{\"query\": \"{ issue(id: \\\"$identifier\\\") { id } }\"}" | jq -r '.data.issue.id')

  gql "{\"query\": \"mutation CreateComment(\$input: CommentCreateInput!) { commentCreate(input: \$input) { success comment { id } } }\", \"variables\": {\"input\": {\"issueId\": \"$issue_id\", \"body\": \"$body\"}}}" \
    | jq -r 'if .data.commentCreate.success then "Comment added" else "Error: \(.errors // .data)" end'
}

# ── Dispatch ──────────────────────────────────────────────────────────────────
CMD="${1:-help}"; shift || true
case "$CMD" in
  list)    cmd_list "$@" ;;
  get)     cmd_get "$@" ;;
  create)  cmd_create "$@" ;;
  update)  cmd_update "$@" ;;
  comment) cmd_comment "$@" ;;
  *)
    echo "Linear CLI — OpenClaw Skill"
    echo ""
    echo "Usage: linear.sh <command> [options]"
    echo ""
    echo "Commands:"
    echo "  list    [--team KEY] [--state active|backlog|done|NAME] [--limit N]"
    echo "  get     IDENTIFIER"
    echo "  create  --team KEY --title \"Title\" [--desc \"...\"] [--priority 1-4]"
    echo "  update  IDENTIFIER --state \"State Name\" | --priority N"
    echo "  comment IDENTIFIER --body \"Text\""
    ;;
esac
