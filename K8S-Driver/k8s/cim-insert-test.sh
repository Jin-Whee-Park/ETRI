RESTSERVER=localhost

 # for Cloud Driver Info
curl -X POST http://$RESTSERVER:1024/driver -H 'Content-Type: application/json' -d '{"DriverName":"k8s-driver","ProviderName":"K8S", "DriverLibFileName":"k8s-driver-v1.0.so"}'

 # for Cloud Credential Info
curl -X POST http://$RESTSERVER:1024/credential -H 'Content-Type: application/json' -d '{"CredentialName":"k8s-credential","ProviderName":"K8S", "KeyValueInfoList": [{"Key":"ClientId", "Value":"xxxxxxxxxxxxxxxxxx"}, {"Key":"ClientSecret", "Value":"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/"}]}'

 # Cloud Region Info for Shooter
curl -X POST http://$RESTSERVER:1024/region -H 'Content-Type: application/json' -d '{"RegionName":"k8s-etri","ProviderName":"K8S", "KeyValueInfoList": [{"Key":"Region", "Value":"kr-etri-2"}]}'


 # Cloud Connection Config Info for Shooter
curl -X POST http://$RESTSERVER:1024/connectionconfig -H 'Content-Type: application/json' -d '{"ConfigName":"k8s-etri-config","ProviderName":"K8S", "DriverName":"k8s-driver", "CredentialName":"k8s-credential", "RegionName":"k8s-etri"}'

