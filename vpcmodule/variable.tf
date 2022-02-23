#variable
variable "vpccidr" {
    description = "This is for my cidr block"
    type = string 
}
variable "WebsubnetNames" {
    description = "number of websubnet" 
    type = number    
}
variable "websubnet_cidr" {
    description = "websubnet cidr"
}
variable "appsubnet_cidr" {
    description = "for app subnet"
  
}
variable "AppsubnetNames" {
    description = "for app subname"
 type = number
}