resource "aws_instance" "master" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.app.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  # key name
  key_name = var.key_name

  # user data for master server
  user_data = file("install_master_sw.sh")

  tags = {
    Name = "Master-Server"
  }
}
