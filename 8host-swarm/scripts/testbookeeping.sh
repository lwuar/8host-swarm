#! /usr/bin/env bash

orderename=(orderer orderer2 orderer3 orderer4)
port=(7050 8050 9050 10050)

declare -i j=0

echo ${orderename[j]}

for i in {1..1000}
do
    docker exec cli peer chaincode invoke -o ${orderename[j]}.example.com:${port[j]} --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n fabcar --peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0.org2.example.com:9051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c "{\"Function\":\"CreateAsset\", \"Args\":[\"fhg{$i}\", \"?D(G+KbPeShVmYq3t6w9z\$B&E)H@McQf\", \"c\", \"d\"]}"

done
