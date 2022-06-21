resource "aws_launch_configuration" "wordpress-lc" {
  name_prefix   = "wordpress-lc"
  image_id      = var.ami
  instance_type = "t2.micro"
  key_name = var.keyname
  security_groups = ["${aws_security_group.ec2_allow_rule.id}"]
  root_block_device {
            volume_type = "gp3"
            volume_size = 10
            encrypted   = true
        }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "wordpress-asg" {
  name                 = "wordpress-asg"
  launch_configuration = aws_launch_configuration.wordpress-lc.name
  min_size             = 1
  max_size             = 1
  vpc_zone_identifier       = [aws_subnet.private-1.id, aws_subnet.private-2.id]
  lifecycle {
    create_before_destroy = true
  }
}
