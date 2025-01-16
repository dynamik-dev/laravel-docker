FROM dunglas/frankenphp

ARG USER=www-data

# Install wkhtmltopdf and supervisor
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN install-php-extensions \
    bcmath \
    pcntl \
    exif \
    gd \
    zip \
    pdo_pgsql \
    pdo_mysql \
    redis \
    intl \
    sockets \
    imagick

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Add Caddyfile
COPY docker/laravel/Caddyfile /config/caddy/Caddyfile

# Add supervisor configuration
COPY docker/laravel/supervisor.conf /etc/supervisor/supervisord.conf

# Add startup script
COPY docker/laravel/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

RUN \
    useradd -D ${USER}; \
    setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/frankenphp; \
    chown -R ${USER}:${USER} /data/caddy && chown -R ${USER}:${USER} /config/caddy; \
    mkdir -p /var/log/supervisor; \
    chown -R ${USER}:${USER} /var/log/supervisor

COPY . /app
RUN chown -R ${USER}:${USER} /app

USER ${USER}
WORKDIR /app
RUN composer install

# Change to use our startup script
CMD ["/usr/local/bin/start.sh"]