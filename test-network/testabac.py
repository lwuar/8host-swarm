import time
import os
import secrets

names = ["creator1", "creator2"]


count = False
j= 0
for i in range (10):

    ranstr = secrets.token_hex(256)

    # print(ranstr)
    if(i%2==0):
        j+=1
        command1 = "export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/" +names[j%2]+"@org1.example.com/msp"
        print(command1)
        print("\n")

    # os.system(command1)
    # # export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/creator1@org1.example.com/msp
    # # export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/creator2@org1.example.com/msp

    command2 = "time peer chaincode invoke $TARGET_TLS_OPTIONS -C mychannel -n abac -c '{\"function\":\"CreateAsset\",\"Args\":[\"Asset"+str(i) +"\",\""+ranstr+"\"]}'"
    print(command2)


    # start = time.time()
    # status=os.system(command2)
    
    # end = time.time()
    # print(status)
    # print(end - start)
    print("\n")
        
