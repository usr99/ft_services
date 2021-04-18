FROM alpine:3.13.4

RUN apk update && apk upgrade																							\
	&& apk add nginx nano wget openssl																					\
	&& apk add php7 php7-fpm php7-session php7-mbstring php7-mysqli php7-json php7-zlib php7-opcache php7-curl php7-gd	\
	&& apk add mariadb mariadb-client

# Give ownership to nginx user
RUN chown -R nginx:www-data var/www/*
RUN chmod -R 777 var/www/*

# Copy configuration files
COPY nginx.conf /etc/nginx
COPY ssl.conf /etc/nginx/conf.d
# Create server
RUN mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled
COPY wordpress.conf /etc/nginx/sites-available/wordpress.conf
RUN ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/wordpress

# Install Wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -zxf latest.tar.gz -C /var/www
# Configure Wordpress
COPY wp-config.php /var/www/wordpress

# Generate SSL certificate and key
RUN mkdir var/www/wordpress/ssl
RUN openssl req -nodes -subj '/CN=localhost' -x509 -newkey rsa:4096 -keyout /var/www/wordpress/ssl/key.pem -out /var/www/wordpress/ssl/cert.pem -days 365

# Copy Wordpress database template
COPY template.sql .
# Copy init script
COPY init.sh .
RUN chmod +x init.sh

# Launch init script
CMD ./init.sh
