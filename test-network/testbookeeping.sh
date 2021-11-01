#! /usr/bin/env bash


for i in {1..1000}
do
    # peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c     "{\"function\":\"CreateAsset\",\"Args\":[\"asset$i\",\"?D(G+KbPeShVmYq3t6w9z\$B&E)H@McQf\",\"Tom\",\"Jerry\"]}"
    peer chaincode invoke $TARGET_TLS_OPTIONS -C mychannel -n basic -c  "{\"function\":\"CreateAsset\",\"Args\":[\"asset$i\",\"?D(G+KbPeShVmYq3t6w9z\$B&E)H@McQf\",\"Tom\",\"Jerry\"]}"
done