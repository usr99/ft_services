minikube delete
docker stop $(docker ps -aq)
docker rmi -f $(docker images -aq)
