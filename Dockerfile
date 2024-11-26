# Use a lightweight base image
FROM debian:bullseye-slim

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive \
    STATIC_PAGE_TITLE="Inflight"

# Update OS and install Nginx
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Generate self-signed SSL certificate
RUN mkdir -p /etc/nginx/ssl && \
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/nginx.key \
  -out /etc/nginx/ssl/nginx.crt \
  -subj "/C=US/ST=State/L=City/O=Org/CN=heli.technology" \
  -addext "subjectAltName=DNS:heli.technology"

#RUN mkdir -p /etc/nginx/ssl && \
#    openssl genrsa -out /etc/nginx/ssl/nginx.key 2048 && \
#    openssl req -new -key /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.csr \
#        -subj "/C=US/ST=State/L=City/O=Org/CN=heli.technology" && \
#    openssl x509 -req -days 365 -in /etc/nginx/ssl/nginx.csr -signkey /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

# Copy custom configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY log_format.conf /etc/nginx/conf.d/log_format.conf

# Create entrypoint script to generate dynamic content
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose port 443 for HTTPS
EXPOSE 443

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default CMD to start Nginx
CMD ["nginx", "-g", "daemon off;"]
