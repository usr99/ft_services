FROM alpine:3.13.4

RUN apk update && apk upgrade	\
	&& apk add nano telegraf

# Copy Telegraf configuration
RUN mkdir /etc/telegraf
COPY telegraf.conf /etc/telegraf

# Launch Telegraf
CMD telegraf
