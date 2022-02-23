/*
module "vpcmodule" {
  source = "./vpcmodule"

  vpccidr        = var.vpccidr
  WebsubnetNames = 3
  websubnet_cidr = [for each in range(0, 225, 2) : cidrsubnet(var.vpccidr, 8, each)]
  appsubnet_cidr = [for each in range(1, 225, 2) : cidrsubnet(var.vpccidr, 8, each)]
  AppsubnetNames = 3
}*/

resource "aws_security_group" "CamtelfrontendSG" {
  name        = "CamtelWebRTSG"
  description = "Allow shh inbound traffic"


  ingress {
    description = "shh from my ip"
    from_port   = var.WebSGport
    to_port     = var.WebSGport
    protocol    = "tcp"
    cidr_blocks = ["141.156.222.213/32"]
  }
  ingress {
    description = "allow port 8080"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "CamtelWebSG"
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "CametAppRTSG" {
  name        = "CametAppRTSG"
  description = "Allow TLS inbound traffic"
 # vpc_id      = local.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = var.AppSGport
    to_port     = var.AppSGport
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "CametAppRTSG"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_lb" "Application" {
  name            = "Application-lb"
  internal        = false
  security_groups = [aws_security_group.CamtelfrontendSG.id]
  idle_timeout    = 400
 # subnets         = module.vpcmodule.websubnet_id
  tags = {
    Environment = "prod"
  }
}
resource "aws_lb_target_group" "ip_mtglb" {
  name     = "tf-example-lb-tg"
  port     = 8080
  protocol = "HTTP"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.Application.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_mtglb.arn
  }
}
