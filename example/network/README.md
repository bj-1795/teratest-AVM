# Terraform module for creating network skeleton
  - VPC
  - Subnet
  - Route table
  - transit_gateway_attachment

## Usage

```
# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

#Create Network components
module "Network" {
  source             = "./network/"
  vpc_name           = var.vpc_name
  cidr_block         = var.cidr_block
  secondary_cidr     = var.secondary_cidr
  subnet_values      = var.subnet_values
  region             = var.region
  tg_subnets         = var.tg_subnets
  subnet_az          = var.subnet_az
  transit_gateway_id = var.transit_gateway_id
  tags               = var.tags
}

```

## Inputs

| Name | Description | Type | Required | 
|------|-------------|:----:|:--------:|
| vpc_name | The name of the VPC. | string |  yes | 
| cidr_block | The Primmary CIDR block for the VPC. | string | yes | 
| secondry_cidr | The secondary CIDR block for the VPC. | list(string) |  yes | 
| subnet_values | The Values for subnet to be created. | list(map) | yes | 
| region | The Region in which subnet will be created. | string | yes | 
| tg_subnet | The CIDRs range for the subnets to be attached to transit gateway. | list(string) | yes |
| subnet_az | The name Availability zones in which subnet will be created. | list(string) | yes |
| transit_gateway_id | Transit gateway Id to be attached to routetable | string | yes |
| tags | A map of tags to add | map | no |

## Sample JSON for Input
```
{ "vpc_name" : "Xplatform_vpc", 
"cidr_block" : "10.2.0.0/16",
"secondary_cidr" : ["10.3.0.0/16", "10.4.0.0/16"],
"subnet_values" : [
{
      "cidr"        : ["10.2.1.0/24", "10.2.2.0/24"],
      "subnet_name" : "SCBTechX-subnet"
      },
      {
        "cidr"        : ["10.2.3.0/24", "10.2.4.0/24"],
        "subnet_name" : "Xplatform-subnet"
      },
      {
        "cidr"        : ["10.2.5.0/24", "10.2.6.0/24"],
        "subnet_name" : "Protected-subnet"
      }
    ],
"region"  : "us-east-1",
"tg_subnets"  : ["10.2.3.0/24", "10.2.4.0/24"],
"subnet_az"  : ["a", "b"],
"tags": {
    "PlatformEnvType" : "nonprod",
	"Environment"  : "devops",
    "Owner" : "SCBtechX-Xplatform"
 },
"transit_gateway_id" : "tgw-XXXXXXXXX"
}

```

## Outputs

| Name | Description |  
|------|-------------|
| vpc_id | The ID of the created VPC. |
| subnet_ids | The subnet_ids of the created Subnets. |
| arn | The ARN of the created VPC |
