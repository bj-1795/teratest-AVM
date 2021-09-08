package test

import (
	"encoding/json"
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Standard Go test, with the "Test" prefix and accepting the *testing.T struct.
func TestNetwork(t *testing.T) {
	// I work in eu-west-2, you may differ
	awsRegion := "ap-southeast-1"
	type M map[string]interface{}
	var myMapSlice []M

	m1 := M{"cidr": []string{"10.237.252.0/24", "10.237.253.0/24", "10.237.254.0/24"}, "subnet_name": "aella-nonbank-nonprod"}

	m2 := M{"cidr": []string{"10.237.255.128/26", "10.237.255.0/26", "10.237.255.64/26"}}

	myMapSlice = append(myMapSlice, m1, m2)

	// or you could use `json.Marshal(myMapSlice)` if you want
	myJson, _ := json.MarshalIndent(myMapSlice, "", "    ")
	fmt.Println(myMapSlice)

	//myList := []string{"100.64.128.0/19"}

	// This is using the terraform package that has a sensible retry function.
	terraformOpts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Our Terraform code is in the /aws folder.
		TerraformDir: "../example/network",

		// This allows us to define Terraform variables. We have a variable named
		// "bucket_name" which essentially is a suffix. Here we are are using the
		// random package to get a unique id we can use for testing, as bucket names
		//VarFiles: []string{"../example/network/test.tfvars"},
		Vars: map[string]interface{}{
			"vpc_name":           "test-vpc",
			"region":             "ap-southeast-1",
			"subnet_az":          []string{"a", "b"},
			"tg_subnets":         []string{"10.2.3.0/24", "10.2.4.0/24"},
			"subnet_values":      string(myJson),
			"cidr_block":         "10.237.252.0/22",
			"secondary_cidr":     []string{"10.3.0.0/16", "10.4.0.0/16"},
			"transit_gateway_id": "tgw-08dce9d68c5aed9a6",
			"tags": map[string]string{"Company": "aella",
				"PlatformEnvType": "sandbox"},
		},
	})

	// We want to destroy the infrastructure after testing.
	defer terraform.Destroy(t, terraformOpts)

	// Deploy the infrastructure with the options defined above
	terraform.InitAndApply(t, terraformOpts)

	// Get the bucket ID so we can query AWS
	publicSubnetId := terraform.Output(t, terraformOpts, "public_subnet_id")
	privateSubnetId := terraform.Output(t, terraformOpts, "private_subnet_id")
	//vpcId := terraform.Output(t, terraformOptions, "main_vpc_id")

	//subnets := aws.GetSubnetsForVpc(t, vpcId, awsRegion)

	//require.Equal(t, 2, len(subnets))
	// Verify if the network that is supposed to be public is really public
	assert.True(t, aws.IsPublicSubnet(t, publicSubnetId, awsRegion))
	// Verify if the network that is supposed to be private is really private
	assert.False(t, aws.IsPublicSubnet(t, privateSubnetId, awsRegion))
}
