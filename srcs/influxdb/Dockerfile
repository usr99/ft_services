FROM alpine:3.13.4

RUN apk update && apk upgrade				\
	&& apk add nano influxdb telegraf

RUN mkdir /etc/influxdb								\
	&& influxd config > /etc/influxdb/influxdb.conf	\
	&& chown -R influxdb:influxdb /etc/influxdb		\
	&& mkdir /root/.influxdb						\
	&& chown -R influxdb:influxdb /root/.influxdb

CMD influxd
