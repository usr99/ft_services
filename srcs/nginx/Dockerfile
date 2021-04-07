FROM alpine:3.13.4

RUN apk update && apk upgrade	\
	&& apk add nginx nano openssl

RUN chown -R nginx:www-data var/www/*
RUN chmod -R 777 var/www/*

COPY nginx.conf /etc/nginx
COPY proxy.conf /etc/nginx/conf.d
COPY ssl.conf /etc/nginx/conf.d
RUN mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled
COPY ft_server.conf /etc/nginx/sites-available/ft_server.conf
RUN ln -s /etc/nginx/sites-available/ft_server.conf /etc/nginx/sites-enabled/ft_server

RUN mkdir var/www/ft_server
COPY index.html var/www/ft_server
RUN mkdir var/www/ft_server/ssl
RUN openssl req -nodes -subj '/CN=localhost' -x509 -newkey rsa:4096 -keyout /var/www/ft_server/ssl/key.pem -out /var/www/ft_server/ssl/cert.pem -days 365

CMD nginx