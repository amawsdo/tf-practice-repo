data "aws_subnet_ids" "app_sn" {
  vpc_id = aws_vpc.vpc_tf.id
  tags = {
    Name = "app-tf"
  }
}

resource "aws_lb" "nlb" {
  name               = "nlb-tf"
  internal           = false
  load_balancer_type = "network"
  #subnets - (Optional) A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network. Changing this value for load balancers of type network will force a recreation of the resource.
  #  subnets            = aws_subnet.app.id    #[for subnet in aws_subnet.public : subnet.id]
  subnets                    = data.aws_subnet_ids.app_sn.ids
  enable_deletion_protection = false

  tags = {
    Name = "nlb-tf"
  }
}

/*
data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  tags = {
    Tier = "Private"
  }
}

resource "aws_instance" "app" {
  for_each      = data.aws_subnet_ids.private.ids
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = each.value
}
*/
