wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
source $HOME/.profile

wget https://get.docker.com/

mv index.html installdocker.sh
bash installdocker.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

docker --version
docker-compose --version