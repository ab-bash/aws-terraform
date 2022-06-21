# Create Target groupresource
resource "aws_lb_target_group" "wordpress-tg" {
  name     = "wordpress-tg"
  depends_on = ["aws_vpc.wordpress-vpc"]
  port     = 80
  protocol = "HTTP"
#  target_type = "instance"
  vpc_id   = "${aws_vpc.wordpress-vpc.id}"
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60 
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.wordpress-tg.arn
  target_id        = aws_instance.wordpressec2.id
  port             = 80
}

