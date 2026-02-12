# DB Query

Run SQL queries against MySQL, PostgreSQL, or SQLite databases.

## What It Does

- Execute SELECT queries safely
- Run INSERT/UPDATE with confirmation
- Analyze table structures
- Export query results
- Explain query performance

## Installation

```bash
clawhub install db-query
```

## Requirements

- Database CLI tool installed:
  - `mysql` for MySQL/MariaDB
  - `psql` for PostgreSQL
  - `sqlite3` for SQLite

## Setup

Configure database connections in your environment or OpenClaw config:

```bash
export DB_HOST="localhost"
export DB_USER="username"
export DB_PASS="password"
export DB_NAME="database"
```

## Usage

Ask naturally:

- "Show me all users who signed up this week"
- "What's the total revenue for January?"
- "List tables in the wordpress database"
- "Explain this slow query"
- "Count orders by status"

## Safety

- SELECT queries run immediately
- INSERT/UPDATE/DELETE require confirmation
- DROP and TRUNCATE are blocked by default

## Tags

`database` `sql` `mysql` `postgresql` `sqlite`

## Author

[Skunk Global](https://skunkglobal.com)
