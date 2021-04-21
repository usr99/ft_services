FROM alpine:3.13.4

RUN apk update && apk upgrade				\
	&& apk add nano vsftpd openssl

# vsFTPd configuration file
COPY vsftpd.conf /etc/vsftpd.conf

COPY init.sh .
RUN chmod +x /init.sh

# Create ftp user
RUN echo 'ftp' >> user.tmp ; echo 'ftp' >> user.tmp	\
	&& cat user.tmp | adduser ftp-user				\
	&& rm -f user.tmp								\
	&& echo 'ftp-user' > /etc/vsftpd.userlist

# Generate SSL key and certificate
RUN openssl req -nodes -subj '/CN=ftps-kube' -x509 -newkey rsa:4096 -keyout /etc/ssl/vsftpd.key.pem -out /etc/ssl/vsftpd.cert.pem -days 365	\
	&& chown root:root /etc/ssl/*																											\
	&& chmod 600 /etc/ssl/*

# Launch vsFTPd
CMD ./init.sh
