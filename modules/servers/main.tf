
resource "aws_instance" "app_server" {
  count                       = var.num_servers
  ami                         = "ami-04505e74c0741db8d"
  instance_type               = var.server_size
  subnet_id                   = var.subnet
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg]

  key_name = "DevOps"

  tags = {
    Name = "${var.env}-${count.index}"
  }
}