// Proof of Concepts of CB-Spider.
// The CB-Spider is a sub-Framework of the Cloud-Barista Multi-Cloud Project.
// The CB-Spider Mission is to connect all the clouds with a single interface.
//
//      * Cloud-Barista: https://github.com/cloud-barista
//
// This is a Cloud Driver Example for PoC Test.
//
// by powerkim@etri.re.kr, 2019.06.

package connect

import (
	cblog "github.com/cloud-barista/cb-log"

	irs "github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/interfaces/resources"
	"github.com/sirupsen/logrus"

	krs "github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/drivers/kubernetes/resources"


)

//type K8sCloudConnection struct{}
type K8sCloudConnection struct {
}
var cblogger *logrus.Logger

func init() {
	// cblog is a global variable.
	cblogger = cblog.GetLogger("Cluster Connect")
}

func (c *K8sCloudConnection) CreateVMHandler() (irs.VMHandler, error) {
	cblogger.Info("Start CreateHandler()")	
	vmHandler := krs.VMHandler{}

	return &vmHandler, nil
}

func (c *K8sCloudConnection) IsConnected() (bool, error) {
	return true, nil
}
func (c *K8sCloudConnection) Close() error {
	return nil

}


// CreateVNicHandler ...
func (c *K8sCloudConnection) CreateVNicHandler() (irs.VNicHandler, error) {

        return nil, nil
}

// CreateVNetworkHandler ...
func (c *K8sCloudConnection) CreateVNetworkHandler() (irs.VNetworkHandler, error) {
        return nil, nil
}

// CreateImageHandler ...
func (c *K8sCloudConnection) CreateImageHandler() (irs.ImageHandler, error) {
        return nil, nil
}

// CreateSecurityHandler ...
func (c *K8sCloudConnection) CreateSecurityHandler() (irs.SecurityHandler, error) {
        return nil, nil
}

// CreateKeyPairHandler ...
func (c *K8sCloudConnection) CreateKeyPairHandler() (irs.KeyPairHandler, error) {
        return nil, nil
}

// CreatePublicIPHandler ...
func (c *K8sCloudConnection) CreatePublicIPHandler() (irs.PublicIPHandler, error) {
        return nil, nil
}
func (c *K8sCloudConnection) CreateVMSpecHandler() (irs.VMSpecHandler, error) {
        return nil, nil
}
