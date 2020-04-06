package main

import (
	"C"
	kcon "github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/drivers/kubernetes/connect"
	idrv "github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/interfaces"
        icon "github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/interfaces/connect"
)

type K8sDriver struct{

}

func (K8sDriver) GetDriverVersion() string {
	return "TEST Cluster Driver Version 1.0"
}

func (K8sDriver) GetDriverCapability() idrv.DriverCapabilityInfo {
        var drvCapabilityInfo idrv.DriverCapabilityInfo

        drvCapabilityInfo.ImageHandler = false
        drvCapabilityInfo.VNetworkHandler = false
        drvCapabilityInfo.SecurityHandler = false
        drvCapabilityInfo.KeyPairHandler = false
        drvCapabilityInfo.VNicHandler = false
        drvCapabilityInfo.PublicIPHandler = false
        
	drvCapabilityInfo.VMHandler = true

        return drvCapabilityInfo
}

func (driver *K8sDriver) ConnectCloud(connectionInfo idrv.ConnectionInfo) (icon.CloudConnection, error) {

	iConn := kcon.K8sCloudConnection{}//connectionInfo.CredentialInfo.IdentityEndpoint}
	return &iConn, nil
}
var CloudDriver K8sDriver

