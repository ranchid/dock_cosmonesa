#!/bin/bash

if [ -f ./composer.json ] && [ -f ./artisan ]; then \
    sh -c "
        composer install --no-interaction;
        php artisan config:clear;
        php artisan route:clear;
        php artisan view:clear;
        "; \
    
fi

exec "$@"