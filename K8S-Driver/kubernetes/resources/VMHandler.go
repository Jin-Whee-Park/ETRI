package  resources

import (
	"context"
	"flag"
	"path/filepath"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	appsv1 "k8s.io/api/apps/v1"
	apiv1 "k8s.io/api/core/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/util/homedir"
	"github.com/davecgh/go-spew/spew"
        "github.com/sirupsen/logrus"
	cblog "github.com/cloud-barista/cb-log"
	irs "github.com/cloud-barista/cb-spider/cloud-control-manager/cloud-driver/interfaces/resources"
	"fmt"

)
type VMHandler struct {
}
var cblogger *logrus.Logger

func init () {
        cblogger = cblog.GetLogger("Cluster Handler")
}

func (c *VMHandler) StartVM(vmReqInfo irs.VMReqInfo) (irs.VMInfo, error){
	cblogger.Info(vmReqInfo)
        spew.Dump(vmReqInfo)
//func main() {
	var kubeconfig *string
	if home := homedir.HomeDir(); home != "" {
		kubeconfig = flag.String("kubeconfig", filepath.Join(home, ".kube", "config"), "(optional) absolute path to the kubeconfig file")
	} else {
		kubeconfig = flag.String("kubeconfig", "", "absolute path to the kubeconfig file")
	}
	flag.Parse()

	config, err := clientcmd.BuildConfigFromFlags("", *kubeconfig)
	if err != nil {
		panic(err)
	}
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err)
	}

	deploymentsClient := clientset.AppsV1().Deployments(apiv1.NamespaceDefault)

	deployment := &appsv1.Deployment{
                ObjectMeta: metav1.ObjectMeta{
                        Name: "sender",
                },
                Spec: appsv1.DeploymentSpec{
                        Replicas: int32Ptr(1),
                        Selector: &metav1.LabelSelector{
                                MatchLabels: map[string]string{
                                        "app": "sender",
                                },
                        },
                        Template: apiv1.PodTemplateSpec{
                                ObjectMeta: metav1.ObjectMeta{
                                        Labels: map[string]string{
                                                "app": "sender",
                                        },
                                },
                                Spec: apiv1.PodSpec{
                                        Containers: []apiv1.Container{
                                                {
                                                        Name:  "sender",
							Image: "best888810/sender:sender",
                                                        Ports: []apiv1.ContainerPort{
                                                                {
                                                                        Name:          "sender",
                                                                        Protocol:      apiv1.ProtocolTCP,
                                                                        ContainerPort: 80,
                                                                },
                                                        },
                                                },
                                        },
                                },
                        },
                },
        }

	// Create Deployment
//	deploymentsClient.Create(context.TODO(), deployment,  metav1.CreateOptions{})

//	deploymentsClient.Create(*"k8s.io/api/apps/v1".Deployment)

	// Create Deployment
	fmt.Println("Creating deployment...")
	result, err := deploymentsClient.Create(context.TODO(), deployment, metav1.CreateOptions{})
	if err != nil {
		panic(err)
	}
	fmt.Printf("Created deployment %q.\n", result.GetObjectMeta().GetName())

	newVmInfo, _ := c.GetVM(vmReqInfo.VMName)
	return newVmInfo, nil
}

func int32Ptr(i int32) *int32 { return &i }

func (c *VMHandler) SuspendVM(vmID string) (irs.VMStatus, error) {
        return irs.Failed, nil
}

// ResumeVM ...
func (c *VMHandler) ResumeVM(vmID string)  (irs.VMStatus, error){
        return irs.Failed, nil
}

// RebootVM ...
func (c *VMHandler) RebootVM(vmID string) (irs.VMStatus, error) {
        return irs.Failed, nil
}

// TerminateVM ...
func (c *VMHandler) TerminateVM(vmID string) (irs.VMStatus, error) {
/*      reqConfig := readConfigFile()
        fmt.Println("Deleting deployment...")
        deletePolicy := metav1.DeletePropagationForeground
        if err := deploymentsClient.Delete(context.TODO(), reqConfig.K8s.Object_Name, &metav1.DeleteOptions{
                PropagationPolicy: &deletePolicy,
        }); err != nil {
                panic(err)
        }
        fmt.Println("Deleted deployment.")
*/
        return irs.Terminated, nil

}



// ListVMStatus ...
func (c *VMHandler) ListVMStatus() ([]*irs.VMStatusInfo, error) {
        var vmStatusList []*irs.VMStatusInfo
        vmStatusInfo := irs.VMStatusInfo{
                VmName:  "",
                VmId:  "",
                VmStatus:  "",
        }
        vmStatusList = append(vmStatusList, &vmStatusInfo)
        return vmStatusList, nil
}

// GetVMStatus ...
func (c *VMHandler) GetVMStatus(vmID string) (irs.VMStatus , error) {


        vmStat := irs.VMStatus("")
        return vmStat, nil
}

// ListVM ...
func (c *VMHandler) ListVM() ([]*irs.VMInfo, error) {

        var vmList []*irs.VMInfo
        vmInfo := irs.VMInfo{}
        vmList = append(vmList, &vmInfo)

        return vmList, nil
}


func (c *VMHandler) GetVM(vmID string) (irs.VMInfo, error) {

        vmInfo := irs.VMInfo{}
        return vmInfo, nil
}

