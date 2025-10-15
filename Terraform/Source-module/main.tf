resource "aws_instance" "This" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
        Name = var.Name
    }
  
}