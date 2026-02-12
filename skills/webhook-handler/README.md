# Webhook Handler

Create, manage, and respond to incoming webhooks.

## What It Does

- Receive and process webhook payloads
- Route webhooks to appropriate actions
- Log and debug webhook deliveries
- Create webhook endpoints
- Validate webhook signatures

## Installation

```bash
clawhub install webhook-handler
```

## Requirements

- OpenClaw gateway running with webhook endpoint enabled

## Setup

Webhooks are received at your OpenClaw gateway URL:
```
https://your-gateway.com/webhooks/{endpoint-name}
```

Configure endpoints in your OpenClaw config.

## Usage

Ask naturally:

- "Show me recent webhook deliveries"
- "Create a webhook endpoint for Stripe events"
- "What payload did the last GitHub webhook send?"
- "Debug why the webhook isn't triggering"
- "List all configured webhook endpoints"

## Tags

`webhooks` `api` `automation` `integration`

## Author

[Skunk Global](https://skunkglobal.com)
