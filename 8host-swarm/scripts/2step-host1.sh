# for  host 1
# multipass exec q$i -- sudo cp -r /home/asetr/UROP/fabric-samples ~
docker swarm init --advertise-addr 10.74.232.202
docker swarm join-token manager
