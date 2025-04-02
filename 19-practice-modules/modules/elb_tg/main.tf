provider "aws" {
    region = "eu-west-1"
}

resource "aws_lb_target_group" "my-tg" {
    name = "my-demo-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = "vpc-098619d88bf464cbe"
    
}

resource "aws_lb" "my-lb" {
    name = "my-demo-elb"
    load_balancer_type = "application"
    security_groups = [ "sg-013ef36435de1738d" ]
    subnets = [ "subnet-0e2604974ab1b723a","subnet-027995a49277edbed","subnet-08fd5ca933492eef7"]
    

    tags = {
      "Environment" = "development" 
    }
}

resource "aws_lb_target_group_attachment" "ins-1" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = "i-06d6213347f27ccd3"
  port             = 80
}

resource "aws_lb_target_group_attachment" "ins-2" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = "i-0c2225f079dc10f1e"
  port             = 80
}

resource "aws_lb_listener" "my-listener" {
    load_balancer_arn = aws_lb.my-lb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.my-tg.arn
    }
}