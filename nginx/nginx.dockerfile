# Use the official Nginx image as the base image
FROM nginx:latest

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your nginx.conf into Nginx configuration directory
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
