FROM nginx:alpine

# Set NGINX_PORT to PORT
RUN echo "export NGINX_PORT=$PORT" > /docker-entrypoint.d/30-update-port-env.sh

# Add Header
RUN sed -i '/location \//a        location /largefile { add_header Transfer-Encoding chunked; }' /etc/nginx/conf.d/default.conf

# Update index.html
RUN echo "This is a large file download demo, <a href=\"./largefile\">Click here Download</a>!" > /usr/share/nginx/html/index.html



# Generate large file
RUN fallocate -l 64MB /usr/share/nginx/html/largefile
