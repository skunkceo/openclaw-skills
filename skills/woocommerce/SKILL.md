# WooCommerce

Install and manage WooCommerce stores via WP-CLI. Products, orders, customers, coupons, and settings.

## When to Use

Use this skill when the user wants to:
- Install or update WooCommerce
- Set up a new store (currency, location, shipping)
- Manage products, inventory, and pricing
- Process or update orders
- Manage customer accounts
- Create and manage coupons
- Configure payment gateways and shipping

## Installing WooCommerce

If the user asks to "install WooCommerce" or "set up a store":

```bash
# For WordPress Studio local development
studio wp plugin install woocommerce --activate

# For standard WordPress
wp plugin install woocommerce --activate
```

**Important:** After activation, ALWAYS run the database update to ensure all tables are created properly. Some environments (especially local dev like WordPress Studio) may have restrictive DB permissions that prevent table creation during activation:

```bash
# Run database update to create all required tables
studio wp wc update  # or: wp wc update

# Verify it worked (should show no pending updates)
studio wp wc update --dry-run
```

If you see errors about missing tables (like `wp_wc_reserved_stock`), this usually means the DB user lacks CREATE privileges. The `wp wc update` command will retry table creation.

After installation, help them configure basic store settings:
```bash
# Set store location (UK example)
studio wp wc setting update general woocommerce_default_country --value="GB"

# Set currency
studio wp wc setting update general woocommerce_currency --value="GBP"

# Enable tax if needed
studio wp option update woocommerce_calc_taxes yes
```

## Prerequisites (After Installation)

Verify WooCommerce is working:
```bash
studio wp wc --info
```

## Products

```bash
# List all products
wp wc product list

# List with filters
wp wc product list --status=publish --type=simple
wp wc product list --category=clothing --in_stock=true
wp wc product list --on_sale=true --format=json

# Get a specific product
wp wc product get 123
wp wc product get 123 --format=json

# Create a simple product
wp wc product create --name="New Product" --type=simple --regular_price="19.99"
wp wc product create --name="Sale Item" --regular_price="29.99" --sale_price="19.99" --status=publish

# Create with full details
wp wc product create \
  --name="Premium Widget" \
  --type=simple \
  --regular_price="49.99" \
  --description="A premium quality widget" \
  --short_description="Premium widget" \
  --sku="WIDGET-001" \
  --manage_stock=true \
  --stock_quantity=100 \
  --categories='[{"id":15}]'

# Update a product
wp wc product update 123 --regular_price="24.99"
wp wc product update 123 --stock_quantity=50
wp wc product update 123 --status=draft
wp wc product update 123 --sale_price="19.99" --date_on_sale_from="2024-01-01" --date_on_sale_to="2024-01-31"

# Delete a product
wp wc product delete 123 --force
```

## Orders

```bash
# List orders
wp wc shop_order list
wp wc shop_order list --status=processing
wp wc shop_order list --customer=42 --format=json
wp wc shop_order list --after="2024-01-01" --before="2024-01-31"

# Get order details
wp wc shop_order get 456
wp wc shop_order get 456 --format=json

# Update order status
wp wc shop_order update 456 --status=completed
wp wc shop_order update 456 --status=refunded

# Add order note
wp wc order_note create 456 --note="Shipped via FedEx, tracking: 123456"
wp wc order_note create 456 --note="Customer called about delivery" --customer_note=false

# List order notes
wp wc order_note list 456
```

## Customers

```bash
# List customers
wp wc customer list
wp wc customer list --role=customer --format=json
wp wc customer list --search="john@example.com"

# Get customer details
wp wc customer get 42
wp wc customer get 42 --format=json

# Create customer
wp wc customer create --email="new@customer.com" --password="securepass123"
wp wc customer create \
  --email="john@example.com" \
  --first_name="John" \
  --last_name="Doe" \
  --password="securepass123" \
  --billing='{"first_name":"John","last_name":"Doe","address_1":"123 Main St","city":"New York","state":"NY","postcode":"10001","country":"US"}'

# Update customer
wp wc customer update 42 --first_name="Jane"
wp wc customer update 42 --billing='{"phone":"555-1234"}'

# Delete customer
wp wc customer delete 42 --force --reassign=1
```

## Coupons

```bash
# List coupons
wp wc shop_coupon list
wp wc shop_coupon list --format=json

# Get coupon
wp wc shop_coupon get 789

# Create coupon
wp wc shop_coupon create --code="SAVE10" --discount_type=percent --amount="10"
wp wc shop_coupon create \
  --code="FREESHIP" \
  --discount_type=fixed_cart \
  --amount="0" \
  --free_shipping=true

# Update coupon
wp wc shop_coupon update 789 --amount="15"
wp wc shop_coupon update 789 --usage_limit=100

# Delete coupon
wp wc shop_coupon delete 789 --force
```

## Settings & Config

```bash
# List payment gateways
wp wc payment_gateway list
wp wc payment_gateway get stripe
wp wc payment_gateway update stripe --enabled=true

# List shipping zones
wp wc shipping_zone list
wp wc shipping_zone get 1

# Tax settings
wp wc tax list
wp wc tax create --country=US --state=CA --rate="7.25" --name="CA Tax"
```

## Reports

```bash
# Sales report
wp wc report sales --period=week
wp wc report sales --date_min="2024-01-01" --date_max="2024-01-31" --format=json

# Top sellers
wp wc report top_sellers --period=month

# Customer totals
wp wc report customers/totals
```

## Inventory Management

```bash
# Check low stock
wp wc product list --in_stock=true --stock_quantity="<10" --format=table

# Bulk update stock
wp wc product update 123 --stock_quantity=100
wp wc product update 123 --manage_stock=true --stock_status=instock

# Set backorder settings
wp wc product update 123 --backorders=notify
```

## Output Formats

All commands support `--format`:
- `table` (default) - Human-readable table
- `json` - JSON for parsing
- `csv` - CSV for spreadsheets
- `ids` - Just IDs
- `yaml` - YAML format

## Tips

- Use `--porcelain` to output just the ID (useful for scripting)
- Use `--field=<field>` to get a single field value
- Combine with `jq` for JSON processing: `wp wc product list --format=json | jq '.[] | .name'`
- For WordPress Studio: `studio wp wc product list`

## Common Workflows

### Flash Sale Setup
```bash
# Apply 20% off to all products in a category
for id in $(wp wc product list --category=summer --format=ids); do
  price=$(wp wc product get $id --field=regular_price)
  sale=$(echo "$price * 0.8" | bc)
  wp wc product update $id --sale_price="$sale"
done
```

### Order Processing
```bash
# Get pending orders
wp wc shop_order list --status=pending --format=json

# Mark as processing
wp wc shop_order update 456 --status=processing

# Add tracking note
wp wc order_note create 456 --note="Tracking: ABC123" --customer_note=true

# Complete order
wp wc shop_order update 456 --status=completed
```

## Troubleshooting

### Table creation failed (wp_wc_reserved_stock, etc.)

If you see errors like "WooCommerce `wp_wc_reserved_stock` table creation failed" during or after activation:

```bash
# 1. Check database health
studio wp db check

# 2. Force WooCommerce to recreate tables
studio wp wc update

# 3. If that doesn't work, try deactivate/reactivate
studio wp plugin deactivate woocommerce
studio wp plugin activate woocommerce
studio wp wc update
```

This commonly happens in WordPress Studio or local dev environments with restrictive MySQL permissions.

### WooCommerce commands not working

If `wp wc` commands fail, check WooCommerce REST API is enabled:
```bash
studio wp option get woocommerce_api_enabled
studio wp option update woocommerce_api_enabled yes
```

## Reference

Full docs: https://developer.woocommerce.com/docs/wc-cli/wc-cli-commands/
