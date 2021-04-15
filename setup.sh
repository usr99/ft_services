echo "\033[32;01m#### FT_SERVICES SETUP ####\033[00m"

# launch minikube cluster
minikube start --extra-config=apiserver.service-node-port-range=1-25000
minikube addons enable dashboard
eval $(minikube docker-env)

echo "\033[32;01m#### Build docker images ####\033[00m"

# build docker images
echo "\033[33;01m#### NGINX...\033[00m" ; docker build -qt nginx srcs/nginx
echo "\033[33;01m#### PhpMyAdmin...\033[00m" ; docker build -qt phpmyadmin srcs/phpmyadmin
echo "\033[33;01m#### Wordpress...\033[00m" ; docker build -qt wordpress srcs/wordpress
echo "\033[33;01m#### MySQL...\033[00m" ; docker build -qt mysql srcs/mysql
echo "\033[33;01m#### FTPS SERVER...\033[00m" ; docker build -qt ftps srcs/ftps
echo "\033[33;01m#### InfluxDB...\033[00m" ; docker build -qt influxdb srcs/influxdb
echo "\033[33;01m#### Grafana...\033[00m" ; docker build -qt grafana srcs/grafana
echo "\033[33;01m#### Telegraf...\033[00m" ; docker build -qt telegraf srcs/telegraf

echo "\033[32;01m#### MetalLB Installation ####\033[00m"

# install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
# configure metallb
kubectl apply -f srcs/metallb/lb_config.yaml

echo "\033[32;01m#### Launch Deployments and Services ####\033[00m"

# create deployments/services
kubectl apply -f srcs/influxdb/influxdb.yaml
kubectl apply -f srcs/mysql/mysql.yaml
kubectl apply -f srcs/wordpress/wordpress.yaml
kubectl apply -f srcs/phpmyadmin/pma.yaml
kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/ftps/ftps.yaml
kubectl apply -f srcs/grafana/grafana.yaml
kubectl apply -f srcs/telegraf/telegraf.yaml

echo "\033[32;01m#### Launch K8S Dashboard ####\033[00m"

# deploy dashboard
minikube dashboard & sleep 12
