FROM alpine:3.13.4

RUN apk update && apk upgrade			\
	&& apk add nginx nano wget openssl	\
	&& apk add php7 php7-fpm php7-session php7-mbstring php7-mysqli php7-json php7-zlib php7-opcache php7-curl php7-gd

RUN chown -R nginx:www-data var/www/*
RUN chmod -R 777 var/www/*

COPY nginx.conf /etc/nginx
COPY ssl.conf /etc/nginx/conf.d
RUN mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled
COPY wordpress.conf /etc/nginx/sites-available/wordpress.conf
RUN ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/wordpress

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -zxf latest.tar.gz -C /var/www

RUN mkdir var/www/wordpress/ssl
RUN openssl req -nodes -subj '/CN=localhost' -x509 -newkey rsa:4096 -keyout /var/www/wordpress/ssl/key.pem -out /var/www/wordpress/ssl/cert.pem -days 365

COPY wp-config.php /var/www/wordpress

CMD php-fpm7 -D ; nginx
