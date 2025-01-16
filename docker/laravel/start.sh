#!/bin/bash

# Start supervisord
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

# Check if Laravel Horizon is installed
if [ -f /app/artisan ] && php /app/artisan | grep -q horizon; then
    supervisorctl start horizon
else
    supervisorctl start queue
fi

# Check if Laravel Reverb is installed
if [ -f /app/artisan ] && php /app/artisan | grep -q reverb; then
    supervisorctl start reverb
fi

# Keep the container running
exec tail -f /dev/null 