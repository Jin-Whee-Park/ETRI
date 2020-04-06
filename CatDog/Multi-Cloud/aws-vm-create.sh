#!/bin/bash

# AWS VM 생성 과정
source aws-setup.env
./aws-cim-insert-test.sh

for NAME in "${CONNECT_NAMES[@]}"
do
        echo ========================== $NAME
# VPC 생성
#	curl -sX POST http://$RESTSERVER:1024/vnetwork?connection_name=${NAME} -H 'Content-Type: application/json' -d '{"Name":"CB-VNet"}' |json_pp &
#	echo "AWS VPC 생성 완료!!!!!!!:"
# KeyPair 생성
#	KEY=`curl -sX POST http://$RESTSERVER:1024/keypair?connection_name=$NAME -H 'Content-Type: application/json' -d '{ "Name": "aws-jini-spider-seoul" }' |json_pp | grep PrivateKey |sed 's/"PrivateKey" : "//g' |sed 's/-----",/-----/g' |sed 's/-----"/-----/g'`
#	echo -e ${KEY}
#	echo -e ${KEY} > ./key/${NAME}.key
#	chmod 600 ./key/${NAME}.key


#	echo "AWS Keypair 생성 완료!!!!"

# Public IP / Elastic IP 생성
#	for n in {0..1}
#	do 	
#		curl -sX POST http://$RESTSERVER:1024/publicip?connection_name=${NAME} -H 'Content-Type: application/json' -d '{ "Name": "publicipt'${n}'-jini" }' |json_pp &
		#n=`expr $n + 1`
#	done
#	echo "AWS IP 생성완료!!!!!!"
#	sleep 30
	
# Security Group 생성
#	curl -sX POST http://$RESTSERVER:1024/securitygroup?connection_name=${NAME} -H 'Content-Type: application/json' -d '{ "Name": "security-jini", "SecurityRules": [ {"FromPort": "1", "ToPort" : "65535", "IPProtocol" : "-1", "Direction" : "inbound"} ] }' |json_pp &

#	echo "보안그룹 생성완료@@@@"

#	sleep 40

#	echo "AWS VM 생성 시작"
#AWS 마스터 생성
#	./create_instance/start-multi-Aws-Master.sh
# 인스턴스 생성 Body내용
#	num=0
#       VM_NAME=multi-master
#       PIP_ID=publicipt${num}-jini
#       curl -sX POST http://$RESTSERVER:1024/vm?connection_name=${NAME} -H 'Content-Type: application/json' -d '{
#       "VMName": "'${VM_NAME}'",
#               "ImageId": "ami-0cd7b0de75f5a35d1",
#               "VirtualNetworkId": "'${VNET_ID}'",
#               "NetworkInterfaceId": "",
#               "PublicIPId": "'${PIP_ID}'",
#       "SecurityGroupIds": [ "'${SG_ID}'" ],
#               "VMSpecId": "t3.xlarge",
#               "KeyPairName": "aws-jini-spider-seoul",
#               "VMUserId": ""
#       }' |json_pp &

#	sleep 20
#AWS 워커 생성
#	./create_instance/start-multi-Aws-Worker.sh
#	for n in {1..2} do
	num=1
        
	VM_NAME=multi-Node${num}
	PIP_ID=publicipt${num}-jini
	curl -sX POST http://$RESTSERVER:1024/vm?connection_name=${NAME} -H 'Content-Type: application/json' -d '{
	"VMName": "'${VM_NAME}'",
		"ImageId": "ami-0cd7b0de75f5a35d1",
		"VirtualNetworkId": "'${VNET_ID}'",
		"NetworkInterfaceId": "",
		"PublicIPId": "'${PIP_ID}'",
	"SecurityGroupIds": [ "'${SG_ID}'" ],
		"VMSpecId": "t3.xlarge",
		"KeyPairName": "aws-jini-spider-seoul",
		"VMUserId": ""
	}' |json_pp &
                #n=`expr $n + 1`
               sleep 20
        #done
	echo "AWS VM 생성 완료"

	num=`expr $num + 1`
done

# GCP VM 생성 과정
