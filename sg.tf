# Security group
resource "aws_security_group" "jenkins_traffic" {
  name        = "allow_tls"
  description = "Allow jenkins and ssh inbound outbound traffic"

  # inbound  
  dynamic "ingress" {
      for_each = var.ingressrules
      content {
          from_port   = ingress.value
          to_port     = ingress.value
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }
  
  # outbound
  egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }  

  tags = {
    Name = "Jenkins-SG"  
  }
}

