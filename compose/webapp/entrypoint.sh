#!/bin/bash
set -e
set -u

php artisan config:clear
php artisan route:clear
php artisan view:clear

php artisan migrate

exec "$@"