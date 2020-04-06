#!/bin/bash
source ../setup.env

num=0
for NAME in "${CONNECT_NAMES[@]}"
do
        echo ========================== $NAME
        VNET_ID=cb-vnet
        #echo ${VNET_ID}, ${PIP_ID}, ${SG_ID}, ${VNIC_ID}

        curl -sX POST http://$RESTSERVER:1024/vm?connection_name=${NAME} -H 'Content-Type: application/json' -d '{
            "VMName": "sender",
                "ImageId": "best888810/sender:sender",
                "VirtualNetworkId": "'${VNET_ID}'",
		"NetworkInterfaceId": "",
                "PublicIPId": "",
            "SecurityGroupIds": [ "" ],
                "VMSpecId": "",
                 "KeyPairName": "",
                "VMUserId": ""
        }' |json_pp &


        num=`expr $num + 1`
done

