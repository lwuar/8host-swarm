# ipaddr=("10.74.232.202"  "10.74.232.79"  "10.74.232.168"  "10.74.232.138"  "10.74.232.16" "10.74.232.60"  "10.74.232.78" "10.74.232.17")

for i in {1..8}
do

    echo "q$i start"


    ################################# install dependency #######################
    # multipass exec q$i -- sudo  bash /home/ubuntu/fabric-samples/8host-swarm/scripts/installdept.sh
    ################################# install dependency #######################


    ################################# share file ########################
    # multipass launch -n q$i 
    # multipass mount /home/asetr/UROP/ q$i
    ################################# share file ########################


    ################################# join docker swarm ####################
    # multipass exec q$i -- sudo  docker swarm join --token SWMTKN-1-5gsmooiag5xo9lx5jaj5lxb1t98v24ukv5u614cv6vh3pmoc2h-0xf7m7sb75gnjqfrhrckveped 10.74.232.202:2377 --advertise-addr ${ipaddr[i-1]}
    # multipass exec q$i -- sudo docker network ls
    ################################# join docker swarm ####################




    ################################# copy all ############################
    multipass exec q$i -- sudo cp -r /home/asetr/UROP/fabric-samples /home/ubuntu
    ################################# copy all ############################



    ################################# host n up ############################
    # multipass exec q$i --  sudo bash /home/ubuntu/fabric-samples/8host-swarm/host"$i"up.sh
    # multipass exec q$i --  sudo docker ps -a
    ################################# host n up ############################


    ################################# host n down ############################
    # multipass exec q$i --  sudo  bash /home/ubuntu/fabric-samples/8host-swarm/host"$i"down.sh
    # multipass exec q$i --  sudo docker ps -a
    ################################# host n down ############################





    ########################### update fabric tools #############################
    # multipass exec q$i --  sudo docker pull hyperledger/fabric-orderer:2.4
    # multipass exec q$i --  sudo docker pull hyperledger/fabric-peer:2.4
    # multipass exec q$i --  sudo docker pull hyperledger/fabric-tools:2.4
    # multipass exec q$i --  sudo docker tag  hyperledger/fabric-orderer:2.4  hyperledger/fabric-orderer:latest
    # multipass exec q$i --  sudo docker tag  hyperledger/fabric-peer:2.4  hyperledger/fabric-peer:latest
    # multipass exec q$i --  sudo docker tag  hyperledger/fabric-tools:2.4  hyperledger/fabric-tools:latest
    ########################### update fabric tools #############################






        # docker exec cli peer chaincode invoke -o ${orderename[j]}.example.com:${port[j]} --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n fabcar --peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0.org2.example.com:9051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c "{\"Function\":\"CreateAsset\", \"Args\":[\"fhg{$i}\", \"?D(G+KbPeShVmYq3t6w9z\$B&E)H@McQf\", \"c\", \"d\"]}"












    echo "q$i end"
done