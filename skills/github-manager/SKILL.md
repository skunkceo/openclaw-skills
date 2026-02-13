# GitHub Manager

Manage repositories, pull requests, issues, and GitHub Actions from your agent.

## Usage

When asked to work with GitHub repos, manage PRs, or handle issues:

1. Use `gh` CLI commands for all operations
2. Follow repository conventions for commits and PRs
3. Always check status before making changes

## Common Commands

### Repository Operations

```bash
# Clone a repo
gh repo clone owner/repo

# Create new repo
gh repo create name --public --description "Description"

# View repo info
gh repo view owner/repo

# List repos
gh api /user/repos --jq '.[].full_name'
```

### Pull Requests

```bash
# Create PR
gh pr create --title "Title" --body "Description" --base main

# List PRs
gh pr list

# View PR
gh pr view 123

# Check out PR locally
gh pr checkout 123

# Merge PR
gh pr merge 123 --squash

# Review PR
gh pr review 123 --approve
gh pr review 123 --request-changes --body "Feedback"
```

### Issues

```bash
# Create issue
gh issue create --title "Title" --body "Description" --label "bug"

# List issues
gh issue list

# View issue
gh issue view 123

# Close issue
gh issue close 123

# Add comment
gh issue comment 123 --body "Comment text"
```

### GitHub Actions

```bash
# List workflow runs
gh run list

# View run details
gh run view 12345

# Watch run in progress
gh run watch 12345

# Re-run failed jobs
gh run rerun 12345 --failed

# Trigger workflow
gh workflow run workflow.yml
```

### Branches

```bash
# Create and checkout branch
git checkout -b feature/name

# Push branch
git push -u origin feature/name

# Delete remote branch
git push origin --delete branch-name
```

## Best Practices

1. **Always create branches** — Never commit directly to main
2. **Descriptive commits** — Use conventional commit messages
3. **PR descriptions** — Include context, screenshots, test steps
4. **Link issues** — Use "Fixes #123" in PR descriptions
5. **Request reviews** — Don't merge your own PRs without review

## Commit Message Format

```
type(scope): description

[optional body]

[optional footer]
```

Types: feat, fix, docs, style, refactor, test, chore

## Requirements

- `gh` CLI installed and authenticated
- Git configured with SSH keys
- Repository access permissions
