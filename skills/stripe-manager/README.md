# Stripe Manager

Manage Stripe subscriptions, customers, and payments.

## What It Does

- Look up customer and subscription details
- Check payment status and history
- Handle refunds and credits
- Monitor revenue metrics
- Manage products and prices

## Installation

```bash
clawhub install stripe-manager
```

## Requirements

- Stripe API key (secret key)
- Appropriate API permissions

## Setup

Add your Stripe secret key to OpenClaw config or environment:

```bash
export STRIPE_SECRET_KEY="sk_live_xxx"
```

Use test keys (`sk_test_xxx`) for development.

## Usage

Ask naturally:

- "Look up the subscription for john@example.com"
- "What's our MRR this month?"
- "Issue a $50 refund for invoice INV-123"
- "List customers who cancelled this week"
- "Check if this payment went through"

## Safety

- Read operations run immediately
- Refunds and modifications require confirmation
- Uses Stripe's built-in idempotency

## Tags

`stripe` `payments` `subscriptions` `billing` `saas`

## Author

[Skunk Global](https://skunkglobal.com)
