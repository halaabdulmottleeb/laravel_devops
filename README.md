# Laravel Multitenant Project Setup Guide

## Prerequisites

- PHP version > 8
- MySQL database

## Getting Started

1. **Clone the Repository**:

   ```sh
   git clone https://github.com/halaabdulmottleeb/laravel_devops.git
   cd laravel_devops
   
2. **Configure /etc/hosts File:**:

   ```sh
    127.0.0.2       laravelproject.local
    127.0.0.2       foo.laravelproject.local
    127.0.0.2       bar.laravelproject.local
    127.0.0.2       admin.laravelproject.local
       
3. **Configure Apache2 Virtual Hosts:**:

   ```sh
   sudo nano /etc/apache2/sites-available/000-default.conf

   <VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName laravelproject.local
    ServerAlias *.laravelproject.local
    DocumentRoot /path/to/your/laravel_devops/public
    <Directory /path/to/your/laravel_devops/public>
        AllowOverride All
        Require all granted
    </Directory>
    # ... other config ...
 </VirtualHost>
   
4. **Copy .env.dev to .env:**:

   ```sh
   cp .env.dev .env

5. **Run Composer Install:**:

   ```sh
   composer install


6. **Run Migrations:**:

   ```sh
   php artisan migrate

7. **Run Seeder to Create Tenants:**:

   ```sh
   php artisan db:seed

  

