FROM alpine:3.13.4

RUN apk update && apk upgrade					\
	&& apk add nginx nano wget openssl telegraf	\
	&& apk add php7 php7-fpm php7-session php7-mbstring php7-mysqli php7-json php7-zlib php7-opcache php7-curl php7-gd

# Give ownership to nginx user
RUN chown -R nginx:www-data var/www/*
RUN chmod -R 777 var/www/*

# Install PhpMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz	\
	&& tar -zxf phpMyAdmin-4.9.0.1-all-languages.tar.gz												\
	&& mv phpMyAdmin-4.9.0.1-all-languages /var/www/phpmyadmin										\
	&& mkdir /var/www/phpmyadmin/tmp																\
	&& chmod 777 /var/www/phpmyadmin/tmp
# Configure PhpMyAdmin
COPY config.inc.php /var/www/phpmyadmin

# Copy configuration files
COPY nginx.conf /etc/nginx
COPY ssl.conf /etc/nginx/conf.d
# Create server
RUN mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled
COPY pma.conf /etc/nginx/sites-available/pma.conf
RUN ln -s /etc/nginx/sites-available/pma.conf /etc/nginx/sites-enabled/pma

# Generate SSL certificate and key
RUN mkdir var/www/phpmyadmin/ssl
RUN openssl req -nodes -subj '/CN=localhost' -x509 -newkey rsa:4096 -keyout /var/www/phpmyadmin/ssl/key.pem -out /var/www/phpmyadmin/ssl/cert.pem -days 365

# Launch php-fpm and NGINX
CMD php-fpm7 -D ; nginx
