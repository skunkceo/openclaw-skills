# Email Manager

Read, send, and organize emails through your AI assistant.

## What It Does

- Read and summarize unread emails
- Send emails with attachments
- Search email history
- Organize with labels/folders
- Draft responses for review

## Installation

```bash
skunk install email-manager
```

## Requirements

- IMAP/SMTP credentials for your email provider
- Or Gmail API credentials for Google Workspace

## Setup

Configure email credentials in your OpenClaw config or environment:

```bash
export EMAIL_IMAP_HOST="imap.gmail.com"
export EMAIL_SMTP_HOST="smtp.gmail.com"
export EMAIL_USER="you@example.com"
export EMAIL_PASS="app-password"
```

For Gmail, use an App Password (not your regular password).

## Usage

Ask naturally:

- "Check my unread emails"
- "Send an email to sam@example.com about the meeting"
- "Find emails from Stripe this month"
- "Summarize the newsletter from yesterday"
- "Draft a reply to the last support email"

## Tags

`email` `imap` `smtp` `gmail` `communication`

## Author

[Skunk Global](https://skunkglobal.com)
