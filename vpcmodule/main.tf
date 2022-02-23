#rootmodule

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "CamptelVPC" {
  cidr_block           = var.vpccidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "CamptelVPC"
  }
}
resource "aws_default_route_table" "PrivateRT" {
  default_route_table_id = aws_vpc.CamptelVPC.default_route_table_id

  tags = {
    Name = "PrivateRT"
  }
}

resource "aws_subnet" "CamtelWebsub1" {
  count = var.WebsubnetNames # 3
  vpc_id                  = aws_vpc.CamptelVPC.id
  cidr_block              = var.websubnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Websubnet_${count.index + 1}"
  }
}

resource "aws_subnet" "CamtelAppsubnet1" {
  count = var.AppsubnetNames # 3
  vpc_id            = aws_vpc.CamptelVPC.id
  cidr_block        = var.appsubnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "Appsubnet_${count.index + 1}"
  }
}

resource "aws_internet_gateway" "CamtelWebgw" {
  vpc_id = aws_vpc.CamptelVPC.id

  tags = {
    Name = "CamtelWebgw"
  }
}
resource "aws_route_table" "CamtelWebRT" {
  vpc_id = aws_vpc.CamptelVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.CamtelWebgw.id
  }

  tags = {
    Name = "CamtelWebRT"
  }
}

resource "aws_route_table" "CametAppRT" {
  vpc_id = aws_vpc.CamptelVPC.id

  tags = {
    Name = "CametAppRT"
  }
}

resource "aws_route_table_association" "CamtelRoutetablepub" {
  count = var.WebsubnetNames
  subnet_id      = aws_subnet.CamtelWebsub1.*.id[count.index]
  route_table_id = aws_route_table.CamtelWebRT.id
}
