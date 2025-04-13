FROM dunglas/frankenphp:php8.4

RUN apt-get update && apt-get install -y \
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