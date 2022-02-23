output "vpc_id" {
    description = "for my vpc id"
    value = aws_vpc.CamptelVPC.id 
}

output "vpc_cidrblock" {
    value = aws_vpc.CamptelVPC.cidr_block  
}

output "websubnet_id" {
    value = aws_subnet.CamtelWebsub1.*.id
}