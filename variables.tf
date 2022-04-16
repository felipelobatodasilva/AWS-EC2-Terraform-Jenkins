# var region
variable "region" {
    description = "aws beginner tutorial"
    type = string
    default = "us-east-2"
}

# list port of Security Group
variable "ingressrules" {
    type = list(number)
    default = [8080,22]
}

# AMI EC2 Linux
variable "jenkins_ami" {
    default = "ami-0c7478fd229861c57"
}