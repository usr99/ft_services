# launch minikube cluster
minikube start --extra-config=apiserver.service-node-port-range=1-6000
minikube addons enable dashboard
eval $(minikube docker-env)

# build docker images
docker build -t nginx srcs/nginx
docker build -t phpmyadmin srcs/phpmyadmin
docker build -t wordpress srcs/wordpress
docker build -t mysql srcs/mysql
docker build -t ftps srcs/ftps

# install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
# configure metallb
kubectl apply -f srcs/metallb/lb_config.yaml

# create deployments
kubectl apply -f srcs/mysql/mysql.yaml
kubectl apply -f srcs/wordpress/wordpress.yaml
kubectl apply -f srcs/phpmyadmin/pma.yaml
kubectl apply -f srcs/nginx/nginx.yaml
kubectl apply -f srcs/ftps/ftps.yaml
