# Create ALB

resource "aws_lb" "wordpress-alb" {
   name              = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups  = [aws_security_group.ec2_allow_rule.id]
  subnets          = [aws_subnet.public-1.id,aws_subnet.public-2.id]       
  tags = {
        name  = "wordpress-alb"
       }
}

# Create ALB Listener

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.wordpress-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tg.arn
  }
}
