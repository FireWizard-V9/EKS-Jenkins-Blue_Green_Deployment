resource "aws_key_pair" "my_key" {
  key_name   = "bg-key"
  public_key = file("id_ed25519.pub")
}

resource "aws_launch_template" "bg_template" {
  name_prefix   = "bg-template"
  image_id      = var.ec2_ami
  instance_type = var.aws_ec2_instance_type
  key_name      = aws_key_pair.my_key.key_name

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.ebs_volume_size
      volume_type = "gp3"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.bg_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "BG-App"
    }
  }
}

resource "aws_instance" "bg_instances" {
  count         = 3
  ami           = var.ec2_ami
  instance_type = var.aws_ec2_instance_type
  subnet_id     = element(aws_subnet.bg_subnet[*].id, count.index % 2)
  key_name      = aws_key_pair.my_key.key_name

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bg_sg.id]

  root_block_device {
    volume_size = var.ebs_volume_size
    volume_type = "gp3"
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "terminate"
      spot_instance_type             = "one-time"
    }
  }

  tags = {
    Name = element(["jenkins", "sonarqube", "nexus"], count.index)
  }
}
