docker-compose -f /home/ubuntu/fabric-samples/8host-swarm/host8.yaml down -v
docker rm $(docker ps -aq)
docker rmi $(docker images dev-* -q)
