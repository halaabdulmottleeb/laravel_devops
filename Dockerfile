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

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy composer files for dependency installation
COPY composer.json composer.lock ./
RUN composer install --no-scripts

# Copy the rest of the application
COPY . .

# Set file permissions
RUN chown -R www-data:www-data storage bootstrap/cache

# Install Nginx
RUN apt-get install -y nginx

# Remove default Nginx site configuration
RUN rm /etc/nginx/sites-enabled/default

# Copy your nginx.conf into Nginx configuration directory
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expose ports for both PHP-FPM and Nginx
EXPOSE 9000 80

# Start PHP-FPM and Nginx using supervisor
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
