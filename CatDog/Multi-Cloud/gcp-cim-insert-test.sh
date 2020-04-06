RESTSERVER=localhost

curl -X POST "http://$RESTSERVER:1024/driver" -H 'Content-Type: application/json' -d '{"DriverName":"gcp-driver","ProviderName":"GCP", "DriverLibFileName":"gcp-driver-v1.0.so"}'

 # for Cloud Credential Info
curl -X POST "http://$RESTSERVER:1024/credential" -H 'Content-Type: application/json' -d '{"CredentialName":"gcp-credential","ProviderName":"GCP", "KeyValueInfoList": [{"Key":"PrivateKey", "Value":"Key"},{"Key":"ProjectID", "Value":"byoungseob"}, {"Key":"ClientEmail", "Value":"jini-spider@byoungseob.iam.gserviceaccount.com"}]}'

 # for Cloud Region Info
curl -X POST "http://$RESTSERVER:1024/region" -H 'Content-Type: application/json' -d '{"RegionName":"gcp-seoul-region","ProviderName":"GCP", "KeyValueInfoList": [{"Key":"Region", "Value":"asia-northeast3"},{"Key":"Zone", "Value":"asia-northeast3-a"}]}'

 # for Cloud Connection Config Info
curl -X POST "http://$RESTSERVER:1024/connectionconfig" -H 'Content-Type: application/json' -d '{"ConfigName":"gcp-seoul-config","ProviderName":"GCP", "DriverName":"gcp-driver", "CredentialName":"gcp-credential", "RegionName":"gcp-seoul-region"}'

