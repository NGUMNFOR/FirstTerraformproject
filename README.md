# secondterraformrepo
secondterraformrepo

# USAGE 

```hcl 
module "vpcmodule" {
  source = "./vpcmodule"

  vpccidr        = "vpc-cidr"
  WebsubnetNames = 3(how many websubnet u desire)
  websubnet_cidr = [for each in range(0, 225, 2) : cidrsubnet(var.vpccidr, 8, each)]
  appsubnet_cidr = [for each in range(1, 225, 2) : cidrsubnet(var.vpccidr, 8, each)]
  AppsubnetNames = 3 (Desired app subnet)
}
```
