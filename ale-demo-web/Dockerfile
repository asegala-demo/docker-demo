# Base this image on CentOS 7
FROM centos:7

# Add the official Nginx yum repos file
ADD nginx-centos7.repo /etc/yum.repos.d/

# Create another user that will run nginx
RUN groupadd -r nginx && useradd -r -g nginx nginx

# Install nginx
RUN yum install -y nginx

# Copy our configuration
RUN rm -rf /etc/nginx
COPY config /etc/nginx/
COPY example.com /var/www/example.com/public/

# Define mountable directories
VOLUME ["/etc/nginx/sites-enabled", "/var/log/nginx"]

# Define working directory
WORKDIR /etc/nginx

# Define default command
CMD ["nginx"]

# Expose ports
EXPOSE 80 443