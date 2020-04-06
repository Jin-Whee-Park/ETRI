#!/bin/bash

# GCP VM 생성 과정
source gcp-setup.env
./gcp-cim-insert-test.sh
num=2
for NAME in "${CONNECT_NAMES[@]}"
do
        echo ========================== $NAME
# VPC 생성
	#curl -sX POST http://$RESTSERVER:1024/vnetwork?connection_name=${NAME} -H 'Content-Type: application/json' -d '{"Name":"cb-vnet"}' |json_pp &
	#echo "VPC 생성 완료!!!!!!!:"
# KeyPair 생성
	KEY=`curl -sX POST http://$RESTSERVER:1024/keypair?connection_name=$NAME -H 'Content-Type: application/json' -d '{ "Name": "gcp-jini-spider-seoul" }' |json_pp | grep PrivateKey |sed 's/"PrivateKey" : "//g' |sed 's/-----",/-----/g' |sed 's/-----"/-----/g'`
        echo -e ${KEY}
        echo -e ${KEY} > ./key/${NAME}.key

        chmod 600 ./key/${NAME}.key
	echo "GCP Keypair 생성 완료!!!!"
	sleep 30
# Public IP / Elastic IP 생성
	curl -sX POST http://$RESTSERVER:1024/publicip?connection_name=${NAME} -H 'Content-Type: application/json' -d '{ "Name": "publicipt'${num}'-jini" }' |json_pp &
		#n=`expr $n + 1`
	echo "GCP IP 생성완료!!!!!!"
	sleep 40
	
# Security Group 생성
	curl -sX POST http://$RESTSERVER:1024/securitygroup?connection_name=${NAME} -H 'Content-Type: application/json' -d '{ "Name": "security-jini", "SecurityRules": [ {"FromPort": "1", "ToPort" : "65535", "IPProtocol" : "tcp", "Direction" : "inbound"} ] }' |json_pp &
	echo "보안그룹 생성완료@@@@"

	sleep 60

	echo "GCP VM생성 시작"
#GCP worker 생성
#	./create_instance/start-multi-Gcp-Worker.sh
	IMG_ID=projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20200129a
#for NAME in "${CONNECT_NAMES[@]}"
        VNET_ID=cb-vnet
        PIP_ID=publicipt${num}-jini
        SG_ID1=security-jini
#        #echo ${VNET_ID}, ${PIP_ID}, ${SG_ID}, ${VNIC_ID}
        curl -sX POST http://$RESTSERVER:1024/vm?connection_name=${NAME} -H 'Content-Type: application/json' -d '{
            "VMName": "multi-worker2",
                "ImageId": "'${IMG_ID}'",
                "VirtualNetworkId": "'${VNET_ID}'",
                "NetworkInterfaceId": "",
                "PublicIPId": "'${PIP_ID}'",
            "SecurityGroupIds": [ "'${SG_ID1}'" ],
                "VMSpecId": "n1-standard-4",
                 "KeyPairName": "gcp-jini-spider-seoul",
                "VMUserId": ""
        }' |json_pp &

	echo "GCP VM생성 완료"

	num=`expr $num + 1`
done

