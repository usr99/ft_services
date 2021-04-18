FROM alpine:3.13.4

RUN apk update && apk upgrade						\
	&& apk add nano mariadb mariadb-client openrc

# Copy init script
COPY init.sh .
RUN chmod +x init.sh

# Launch init script
CMD ./init.sh
