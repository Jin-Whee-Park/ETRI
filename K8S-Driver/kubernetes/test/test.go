package main
import (
	"fmt"
	"github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/drivers/kubernetes"

	ifs "github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/interfaces"
	irs "github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/interfaces/resources"
)
func main(){
	driver := new(kubernetes.K8sDriver)
	connectionInfo := ifs.RegionInfo{}
	connection, _ := driver.ConnectCloud(connectionInfo)
	
	vmHandler, err := connection.CreateVMHandler()

	if err != nil {
		panic(err)
	}
	vmReqInfo := irs.VMReqInfo{}
	vmInfo, err := vmHandler.StartVM(VMReqInfo)
	if err != nil {
                panic(err)
        }
	fmt.Println(vmInfo)

}
