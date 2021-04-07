FROM alpine:3.13.4

RUN apk update && apk upgrade						\
	&& apk add nano mariadb mariadb-client openrc

COPY wordpress.sql .
COPY init.sh .
RUN chmod +x init.sh

#RUN openrc							\
#	&& touch /run/openrc/softlevel	\
#	&& rc-update add mariadb

#CMD ./init.sh
