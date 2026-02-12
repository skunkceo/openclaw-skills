# WooCommerce Manager

Manage WooCommerce stores, orders, products, and customers.

## What It Does

- View and manage orders
- Update product inventory and pricing
- Look up customer information
- Generate sales reports
- Handle refunds and order status changes

## Installation

```bash
clawhub install woocommerce-manager
```

## Requirements

- WooCommerce REST API credentials
- Or WP-CLI with WooCommerce installed

## Setup

Option 1 - REST API:
```bash
export WC_STORE_URL="https://yourstore.com"
export WC_CONSUMER_KEY="ck_xxx"
export WC_CONSUMER_SECRET="cs_xxx"
```

Option 2 - WP-CLI (if on same server):
No additional setup needed.

## Usage

Ask naturally:

- "Show me today's orders"
- "What's the inventory for product SKU-123?"
- "Update the price of the Pro plan to $99"
- "Find orders from john@example.com"
- "Generate a sales report for last month"

## Tags

`woocommerce` `wordpress` `ecommerce` `orders` `products`

## Author

[Skunk Global](https://skunkglobal.com)
