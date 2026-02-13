# WooCommerce

Install and manage WooCommerce stores via WP-CLI. Products, orders, customers, coupons, and settings.

## ⚠️ Critical: SQLite Incompatibility

**WooCommerce does NOT work with SQLite databases.** WordPress Studio uses SQLite by default, which causes errors like:

- `wp_wc_reserved_stock table creation failed`
- `wp_actionscheduler_*` tables failing
- Action Scheduler errors with `FOR UPDATE` syntax

**Before installing WooCommerce, check the database type:**
```bash
# Check if using SQLite (WordPress Studio)
studio wp eval "echo defined('DB_ENGINE') ? DB_ENGINE : 'mysql';"

# If it returns 'sqlite', WooCommerce won't work properly
```

**Solutions:**
1. Use MySQL/MariaDB instead of SQLite (recommended for WooCommerce)
2. Use Local by Flywheel, MAMP, or Docker with MySQL
3. Use a remote WordPress host with MySQL

If the user is on WordPress Studio with SQLite, **warn them before proceeding** — WooCommerce will partially install but have persistent table errors.

## When to Use

Use this skill when the user wants to:
- Install or update WooCommerce
- Set up a new store (currency, location, shipping)
- Manage products, inventory, and pricing
- Process or update orders
- Manage customer accounts
- Create and manage coupons
- Configure payment gateways and shipping
- **Diagnose WooCommerce issues** (table errors, setup problems)

## Installing WooCommerce

If the user asks to "install WooCommerce" or "set up a store":

**First, check the database type** (see SQLite warning above). Then:

```bash
# For WordPress Studio (MySQL mode only!)
studio wp plugin install woocommerce --activate

# For standard WordPress
wp plugin install woocommerce --activate
```

**Important:** After activation, run the database update to ensure all tables are created:

```bash
# Run database update to create all required tables
studio wp wc update  # or: wp wc update

# Verify it worked (should show no pending updates)
studio wp wc update --dry-run
```

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

## Troubleshooting & Diagnostics

When the user reports WooCommerce issues, run through this diagnostic flow:

### Step 1: Check Database Type

```bash
# Check database engine
studio wp eval "echo defined('DB_ENGINE') ? DB_ENGINE : (defined('DB_HOST') ? 'mysql' : 'unknown');"

# Check wp-config for sqlite
studio wp eval "echo file_exists(ABSPATH . 'wp-content/db.php') ? 'SQLite adapter present' : 'No SQLite adapter';"
```

**If SQLite is detected:** WooCommerce will NOT work properly. The user needs MySQL/MariaDB. Explain this clearly and stop — no amount of troubleshooting will fix SQLite incompatibility.

### Step 2: Check WooCommerce Tables

```bash
# List all WooCommerce tables
studio wp db query "SHOW TABLES LIKE '%woocommerce%';" --skip-column-names
studio wp db query "SHOW TABLES LIKE '%wc_%';" --skip-column-names

# Expected tables (check these exist):
# - wp_wc_admin_notes, wp_wc_admin_note_actions
# - wp_wc_customer_lookup, wp_wc_order_stats
# - wp_wc_product_meta_lookup
# - wp_wc_reserved_stock (this one often fails)
# - wp_wc_webhooks

# Check Action Scheduler tables (also required):
studio wp db query "SHOW TABLES LIKE '%actionscheduler%';" --skip-column-names
```

### Step 3: Check MySQL Privileges (if MySQL)

```bash
# Check current user privileges
studio wp db query "SHOW GRANTS FOR CURRENT_USER();" 2>/dev/null

# Test CREATE privilege
studio wp db query "CREATE TABLE IF NOT EXISTS wp_wc_test_permissions (id INT); DROP TABLE IF EXISTS wp_wc_test_permissions;"
```

If CREATE fails, the MySQL user needs additional privileges:
```sql
GRANT CREATE, ALTER, DROP ON database_name.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
```

### Step 4: Force Table Recreation

```bash
# Update WooCommerce database
studio wp wc update

# Check for pending updates
studio wp wc update --dry-run

# Nuclear option: deactivate, clear transients, reactivate
studio wp plugin deactivate woocommerce
studio wp transient delete --all
studio wp plugin activate woocommerce
studio wp wc update
```

### Step 5: Check WooCommerce Status

```bash
# System status (shows database issues)
studio wp wc --info

# Check for fatal errors in log
studio wp eval "if (defined('WC_LOG_DIR')) { echo file_get_contents(WC_LOG_DIR . 'fatal-errors.log'); }"
```

### Common Issues Summary

| Error | Cause | Fix |
|-------|-------|-----|
| `wp_wc_reserved_stock` table failed | SQLite or missing CREATE privilege | Use MySQL; grant CREATE |
| `FOR UPDATE` syntax error | SQLite database | Switch to MySQL |
| `actionscheduler` errors | SQLite incompatibility | Switch to MySQL |
| `wp wc` commands fail | REST API disabled | Enable API (see below) |

### WooCommerce Commands Not Working

If `wp wc` commands fail:
```bash
# Check REST API enabled
studio wp option get woocommerce_api_enabled

# Enable if needed
studio wp option update woocommerce_api_enabled yes

# Clear REST cache
studio wp transient delete wc_rest_api_*
```

## Reference

- WC-CLI docs: https://developer.woocommerce.com/docs/wc-cli/wc-cli-commands/
- SQLite limitations: WordPress Studio SQLite is not compatible with WooCommerce
