# create ec2 instance
resource "aws_instance" "jenkins-server" {
  ami                 = var.jenkins_ami
  instance_type       = "t2.micro"
  security_groups  = [aws_security_group.jenkins_traffic.name]
  key_name            = "jenkins-key"

# remote exec install java and jenkins
provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo yum install -y jenkins java-1.8.0-openjdk-devel",
        "sudo yum -y install wget",
        "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo",
        "sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key",
        "sudo yum upgrade -y",
        "sudo yum install jenkins -y",
        "sudo systemctl start jenkins",
    ]
} 
 connection {
    type         = "ssh"
    host         = self.public_ip
    user         = "ec2-user"
    private_key  = file("key/jenkins-key.pem" )
   }
  tags  = {
    "Name"     = "Jenkins-Server"
      }
}