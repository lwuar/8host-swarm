#! /usr/bin/env bash

name="creator1"
j=1
for i in {1..1000}
do
    j=$((j+1))
    if [ $j -eq 2 ] 
    then
        name="creator1"
    fi
    if [ $j -eq 4 ] 
    then
        j=0
        name="creator2"
    fi
    # fi
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/${name}@org1.example.com/msp
    peer chaincode invoke $TARGET_TLS_OPTIONS -C mychannel -n abac -c  "{\"function\":\"CreateAsset\",\"Args\":[\"asset$i\",\"?D(G+KbPeShVmYq3t6w9z\$B&E)H@McQf\",\"Tom\",\"Jerry\"]}"
    
done