FROM alpine:3.13.4

RUN apk update && apk upgrade				\
	&& apk add nano grafana

# Setup configuration folders
RUN rm -f /usr/share/grafana/conf/provisioning/dashboards/sample.yaml		\
	&& rm -f /usr/share/grafana/conf/provisioning/datasources/sample.yaml	\
	&& mkdir /var/lib/grafana/

# Copy configuration files
COPY dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/
COPY datasources.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY grafana-dashboards /var/lib/grafana/dashboards

# Give access to grafana user
RUN chown -R grafana: /var/lib/grafana

CMD cd /usr/share/grafana ; grafana-server
