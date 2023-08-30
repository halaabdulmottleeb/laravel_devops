# Use the official MySQL image as the base image
FROM mysql:latest

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=123456
ENV MYSQL_DATABASE=laravel_devops

EXPOSE 3306

