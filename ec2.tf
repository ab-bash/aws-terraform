# Create EC2 ( only after RDS is provisioned)
resource "aws_instance" "wordpressec2" {
#  ami                    = var.IsUbuntu ? data.aws_ami.ubuntu.id : data.aws_ami.linux2.id
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private-1.id
  vpc_security_group_ids = ["${aws_security_group.ec2_allow_rule.id}"]
#  user_data              = data.template_file.user_data.rendered
  key_name               = aws_key_pair.mykey-pair.id
  tags = {
    Name = "Wordpress-Web"
  }

  root_block_device {
    volume_size = var.root_volume_size # in GB

  }

  # this will stop creating EC2 before RDS is provisioned
#  depends_on = [aws_db_instance.wordpressdb]
}

# Create EC2 ( only after RDS is provisioned)
resource "aws_instance" "bastion" {
#  ami                    = var.IsUbuntu ? data.aws_ami.ubuntu.id : data.aws_ami.linux2.id
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public-1.id
  vpc_security_group_ids = ["${aws_security_group.ec2_allow_rule.id}"]
#  user_data              = data.template_file.user_data.rendered
  key_name               = aws_key_pair.mykey-pair.id
  tags = {
    Name = "Bastion-Host"
  }

  root_block_device {
    volume_size = var.root_volume_size # in GB

  }
}

// Sends your public key to the instance
resource "aws_key_pair" "mykey-pair" {
  key_name   = "mykey-pair"
  public_key = file(var.PUBLIC_KEY_PATH)
}

# creating Elastic IP for EC2
resource "aws_eip" "eip" {
  instance = aws_instance.wordpressec2.id

}

output "IP" {
  value = aws_eip.eip.public_ip
}
#output "RDS-Endpoint" {
#  value = aws_db_instance.wordpressdb.endpoint
#}

output "INFO" {
  value = "AWS Resources and Wordpress has been provisioned. Go to http://${aws_eip.eip.public_ip}"
}
