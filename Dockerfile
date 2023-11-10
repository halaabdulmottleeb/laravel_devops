# Use the official PHP-FPM image as the base image
FROM php:8.0-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy composer files for dependency installation
COPY composer.json  .

RUN composer require fruitcake/laravel-cors
# Install Composer dependencies (without running scripts)
RUN composer install

# Copy the rest of the application
COPY . .

# Set file permissions
RUN chown -R www-data:www-data storage bootstrap/cache

# Generate the application key
RUN php artisan key:generate

# Start PHP-FPM (or your web server) - adjust this based on your setup
CMD ["php-fpm"]
