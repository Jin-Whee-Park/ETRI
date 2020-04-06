RESTSERVER=localhost

LOCS=(`cat k8s-regions-list.txt |grep RegionName |awk '{print $2}' |sed 's/",//g' |sed 's/"//g'`)

for REGION in "${LOCS[@]}"
do
	echo $REGION

	curl -X POST http://$RESTSERVER:1024/region -H 'Content-Type: application/json' -d '{"RegionName":"k8s-'$REGION'","ProviderName":"Kubernetes", "KeyValueInfoList": [{"Key":"Region", "Value":"'$REGION'"}]}'
	curl -X POST http://$RESTSERVER:1024/connectionconfig -H 'Content-Type: application/json' -d '{"ConfigName":"k8s-'$REGION'-config","ProviderName":"Kubernetes", "DriverName":"k8s-driver01", "CredentialName":"k8s-credential01", "RegionName":"k8s-'$REGION'"}'

done
