FROM alpine:3.13.4

RUN apk update && apk upgrade				\
	&& apk add nano vsftpd openssl

COPY vsftpd.conf /etc/vsftpd.conf

RUN echo 'ftp' >> user.tmp ; echo 'ftp' >> user.tmp	\
	&& cat user.tmp | adduser ftp-user				\
	&& rm -f user.tmp								\
	&& echo 'ftp-user' > /etc/vsftpd.userlist

RUN openssl req -nodes -subj '/CN=localhost' -x509 -newkey rsa:4096 -keyout /etc/ssl/vsftpd.key.pem -out /etc/ssl/vsftpd.cert.pem -days 365	\
	&& chown root:root /etc/ssl/*																											\
	&& chmod 600 /etc/ssl/*

CMD vsftpd
