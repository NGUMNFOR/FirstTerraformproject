variable "vpccidr" {
  description = "This is for my vpc cidr"
  type        = string
  default     = "100.0.0.0/16"

}

variable "WebSGport" {
  description = "This is for my Web security group"
  type        = number
  default     = 22

}

variable "AppSGport" {
  description = "This is for my App security group"
  type        = number
  default     = 5432

}
variable "myWebinstance" {
  description = "This is my Webinstance"
  type        = string
  default     = "ami-06cffe063efe892ad"
}
variable "myinstancetype" {
  description = "my instance type"
  type        = string
  default     = "t2.micro"

}
variable "keypair" {
  description = "My key pair"
  type        = string
  default     = "Dec"

}


# Working with List variable 


variable "public_key" {
  description = "This is for my public key"
  type        = string
  default     = "C:\\Users\\ngumj\\.ssh\\id_rsa.pub"

}
# variable "WebsubnetNames" {
#    type = list
#    description = "(optional) describe your variable"
#    default =  ["CamtelWebsub1","CamtelWebsub2", "CDCWebsubnet"]
#  } 

# variable "AppsubnetNames" {
#    type = list
#    description = "(optional) describe your variable"
#    default =  ["CamtelAppsub1","CamtelAppsub2", "CDCAppsubnet"]
#  } 


