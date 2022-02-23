resource "aws_key_pair" "jan2022" {
  key_name   = "id_rsa"
  public_key = file(var.public_key)
}

resource "aws_instance" "web" {
  ami             = var.myWebinstance
  instance_type   = var.myinstancetype
 # subnet_id       = module.vpcmodule.websubnet_id[0]
 # security_groups = [aws_security_group.CamtelfrontendSG.id]
  key_name        = aws_key_pair.jan2022.id
  user_data = base64encode(
    templatefile("${path.cwd}/user_data.sh.tpl",
      {
        vars = []
      }
  ))
  tags = {
    Name = "Webinstance"
  }
  lifecycle {
    ignore_changes = [
      security_groups,
    ]
  }
}

resource "aws_lb_target_group_attachment" "jenkins_tga" {
  target_group_arn = aws_lb_target_group.ip_mtglb.arn
  target_id        = aws_instance.web.id
  port             = 8080
}