server {
  listen [::]:80;
  listen 80;

  # The host name to respond to
  server_name example.com;

  # Path for static files
  root /var/www/example.com/public;

  #Specify a charset
  charset utf-8;

  # Custom 404 page
  error_page 404 /404.html;
}
