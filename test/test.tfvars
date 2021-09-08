{ "vpc_name" : "test_vpc", 
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
"transit_gateway_id" : "tgw-05722765fbc30390c"
}
