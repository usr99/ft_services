FROM alpine:3.13.4

RUN apk update && apk upgrade				\
	&& apk add nano grafana openssl telegraf

# Copy configuration files
COPY dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards
COPY datasources.yaml /usr/share/grafana/conf/provisioning/datasources
COPY grafana-dashboards /var/lib/grafana-dashboards

# Configure grafana
RUN rm -f /usr/share/grafana/conf/provisioning/dashboards/sample.yaml		\
	&& rm -f /usr/share/grafana/conf/provisioning/datasources/sample.yaml	\
	&& chown -R grafana: /var/lib/grafana-dashboards						\
	&& sed -i "s/default_home_dashboard_path =/default_home_dashboard_path = \/var\/lib\/grafana-dashboards\/ftps.json/" /usr/share/grafana/conf/defaults.ini

CMD cd /usr/share/grafana ; grafana-server
