#!/bin/sh
set -e

# Wait for MySQL to be ready
echo "Waiting for MySQL..."
until php -r "exit(@fsockopen('mysql', 3306) ? 0 : 1);" 2>/dev/null; do
    sleep 1
done
echo "MySQL is ready!"

# Install dependencies if vendor doesn't exist
if [ ! -d "vendor" ]; then
    echo "Installing Composer dependencies..."
    composer install --no-interaction
fi

# Generate app key if not set
if [ -z "$APP_KEY" ] || [ "$APP_KEY" = "" ]; then
    echo "Generating application key..."
    php artisan key:generate
fi

# Run migrations
echo "Running migrations..."
php artisan migrate --force

# Create storage link
php artisan storage:link 2>/dev/null || true

# Clear and cache config
php artisan config:clear
php artisan config:cache

exec "$@"
