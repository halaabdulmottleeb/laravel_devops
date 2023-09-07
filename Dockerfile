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
COPY .env.dev .env


# Set file permissions
RUN chown -R www-data:www-data storage bootstrap/cache

# Generate the application key
RUN php artisan key:generate

# Add custom hosts entries to the container's hosts file
COPY custom-hosts /etc/nginx/conf.d/custom-hosts


# # Run migrations
# RUN php artisan migrate --force

# # Run seeders (customize this as needed)
# RUN php artisan db:seed

CMD ["php-fpm"]
