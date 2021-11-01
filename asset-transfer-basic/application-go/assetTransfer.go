/*
Copyright 2121 IBM All Rights Reserved.

SPDX-License-Identifier: Apache-2.0
*/

package main

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"path/filepath"

	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

func toBase64(b []byte) string {
	return base64.StdEncoding.EncodeToString(b)
}

func main() {
	log.Println("============ application-golang starts ============")

	err := os.Setenv("DISCOVERY_AS_LOCALHOST", "true")
	if err != nil {
		log.Fatalf("Error setting DISCOVERY_AS_LOCALHOST environemnt variable: %v", err)
	}

	wallet, err := gateway.NewFileSystemWallet("wallet")
	if err != nil {
		log.Fatalf("Failed to create wallet: %v", err)
	}

	if !wallet.Exists("appUser") {
		err = populateWallet(wallet)
		if err != nil {
			log.Fatalf("Failed to populate wallet contents: %v", err)
		}
	}

	ccpPath := filepath.Join(
		"..",
		"..",
		"test-network",
		"organizations",
		"peerOrganizations",
		"org1.example.com",
		"connection-org1.yaml",
	)

	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromFile(filepath.Clean(ccpPath))),
		gateway.WithIdentity(wallet, "appUser"),
	)
	if err != nil {
		log.Fatalf("Failed to connect to gateway: %v", err)
	}
	defer gw.Close()

	network, err := gw.GetNetwork("mychannel")
	if err != nil {
		log.Fatalf("Failed to get network: %v", err)
	}

	contract := network.GetContract("basic")

	log.Println("--> Submit Transaction: InitLedger, function creates the initial set of assets on the ledger")
	result, err := contract.SubmitTransaction("InitLedger")
	// result, err := contract.SubmitTransaction("GetAllAssets")

	if err != nil {
		log.Fatalf("Failed to Submit transaction: %v", err)
	}
	log.Println(string(result))

	log.Println("--> Evaluate Transaction: GetAllAssets, function returns all the current assets on the ledger")
	result, err = contract.EvaluateTransaction("GetAllAssets")
	if err != nil {
		log.Fatalf("Failed to evaluate transaction: %v", err)
	}
	log.Println(string(result))

	// log.Println("--> Evaluate Transaction: ReadAsset, function returns an asset with a given assetID")
	// result, err = contract.EvaluateTransaction("ReadAsset", "asset19")
	// if err != nil {
	// 	log.Fatalf("Failed to evaluate transaction: %v\n", err)
	// }
	// log.Println(string(result))

	log.Println("--> Evaluate Transaction: AssetExists, function returns 'true' if an asset with given assetID exist")
	result, err = contract.EvaluateTransaction("AssetExists", "asset1")
	if err != nil {
		log.Fatalf("Failed to evaluate transaction: %v\n", err)
	}
	log.Println(string(result))

	log.Println("--> Submit Transaction: TransferAsset asset1, transfer to new owner of Tom")
	_, err = contract.SubmitTransaction("TransferAsset", "asset1", "asset4", "3")
	if err != nil {
		log.Fatalf("Failed to Submit transaction: %v", err)
	}

	log.Println("--> Evaluate Transaction: ReadAsset, function returns 'asset1' attributes")
	result, err = contract.EvaluateTransaction("ReadAsset", "asset1")
	if err != nil {
		log.Fatalf("Failed to evaluate transaction: %v", err)
	}
	log.Println(string(result))

	// log.Println("--> Evaluate Transaction: UploadByte, function add byte array to the DLT")
	// result, err = contract.SubmitTransaction("UploadData", "test3", "04781902374901238947123047")
	// if err != nil {
	// 	log.Fatalf("Failed to Submit transaction: %v", err)
	// }
	// log.Println(string(result))

	/*******
		test upload data
	***/

	bytes, err := ioutil.ReadFile("/home/asetr/fabric-samples/asset-transfer-basic/application-go/hkust.jpg")
	if err != nil {
		log.Fatal(err)
	}

	var base64Encoding string

	// Determine the content type of the image file
	mimeType := http.DetectContentType(bytes)

	// Prepend the appropriate URI scheme header depending
	// on the MIME type
	switch mimeType {
	case "image/jpeg":
		base64Encoding += "data:image/jpeg;base64,"
	case "image/png":
		base64Encoding += "data:image/png;base64,"
	}

	// Append the base64 encoded output
	base64Encoding += toBase64(bytes)

	// Print the full base64 representation of the image
	// fmt.Println(base64Encoding)

	/*** submit image ***/

	// log.Println("--> Submit Transaction: CreateAsset, creates new asset with ID, color, owner, size, and appraisedValue arguments")
	// result, err = contract.SubmitTransaction("CreateAsset", "test8", "0", base64Encoding)
	// if err != nil {
	// 	log.Fatalf("Failed to Submit transaction: %v", err)
	// }
	// log.Println(string(result))

	/*** submit mystring object ***/
	m := make(map[string]string)
	m["hello1"] = "test1"
	m["hello2"] = "test2"
	mapStr, err := json.Marshal(m)
	if err != nil {
		log.Fatalf("Failed to Create Json for Map: %v", err)
	}
	log.Println("--> Submit Transaction: PutStringMap")
	result, err = contract.SubmitTransaction("PutStringMap", "test999", string(mapStr))
	if err != nil {
		log.Fatalf("Failed to Submit transaction: %v", err)
	}
	log.Println(string(result))

	/*** get all asset **/
	log.Println("--> Evaluate Transaction: GetAllAssets, function returns all the current assets on the ledger")
	result, err = contract.EvaluateTransaction("GetAllAssets")
	if err != nil {
		log.Fatalf("Failed to evaluate transaction: %v", err)
	}
	log.Println(string(result))

	/*** get all string **/
	log.Println("--> Evaluate Transaction: GetAllStringMap")
	result, err = contract.EvaluateTransaction("GetAllStringMap")
	if err != nil {
		log.Fatalf("Failed to evaluate transaction: %v", err)
	}
	log.Println(string(result))

	/*** update string map ***/
	m["upate1"] = "Vlasis"
	mapStr, err = json.Marshal(m)
	if err != nil {
		log.Fatalf("Failed to Create Json for Map: %v", err)
	}
	log.Println("--> Submit Transaction: UpdateStringMap")
	result, err = contract.SubmitTransaction("UpdateStringMap", "test999", string(mapStr))
	if err != nil {
		log.Fatalf("Failed to Submit transaction: %v", err)
	}
	log.Println(string(result))

	/*** get all string **/
	log.Println("--> Evaluate Transaction: GetAllStringMap")
	result, err = contract.EvaluateTransaction("GetAllStringMap")
	if err != nil {
		log.Fatalf("Failed to evaluate transaction: %v", err)
	}
	log.Println(string(result))
	log.Println("============ application-golang ends ============")

}

func populateWallet(wallet *gateway.Wallet) error {
	log.Println("============ Populating wallet ============")
	credPath := filepath.Join(
		"..",
		"..",
		"test-network",
		"organizations",
		"peerOrganizations",
		"org1.example.com",
		"users",
		"User1@org1.example.com",
		"msp",
	)

	certPath := filepath.Join(credPath, "signcerts", "cert.pem")
	// read the certificate pem
	cert, err := ioutil.ReadFile(filepath.Clean(certPath))
	if err != nil {
		return err
	}

	keyDir := filepath.Join(credPath, "keystore")
	// there's a single file in this dir containing the private key
	files, err := ioutil.ReadDir(keyDir)
	if err != nil {
		return err
	}
	if len(files) != 1 {
		return fmt.Errorf("keystore folder should have contain one file")
	}
	keyPath := filepath.Join(keyDir, files[0].Name())
	key, err := ioutil.ReadFile(filepath.Clean(keyPath))
	if err != nil {
		return err
	}

	identity := gateway.NewX509Identity("Org1MSP", string(cert), string(key))

	return wallet.Put("appUser", identity)
}
