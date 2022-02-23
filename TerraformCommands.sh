terraform init
terraform plan
terraform apply
terraform fmt --recursive to format you file
[for each in range(0,225,2) : cidrsubnet("100.0.0.0/16", 8, each)] # Only for public subnet
[for each in range(1,225,2) : cidrsubnet("100.0.0.0/16", 8, each)] # Only for private subnet
 terraform plan -out="plan.out" # This is to append the out put value 
 terraform state list   # To check how many resources you have in your template
 concat([aws_subnet.CamtelAppsubnet1.id], [aws_subnet.CamtelAppsubnet2.id]) 