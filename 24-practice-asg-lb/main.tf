provider "aws" {
    region = "eu-west-1"
}

resource "aws_launch_template" "demo-lt" {
    name = "terraform-demo-lt"
    image_id = "ami-03cc8375791cb8bcf"
    key_name = "irl-keypair"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "sg-013ef36435de1738d" ]

    tags = {
      "Name" = "terraform-demo-lt-tags"
    }
}

resource "aws_autoscaling_group" "demo-asg" {
    name = "terraform-demo-asg"
    min_size = 1
    max_size = 4
    desired_capacity = 2
    availability_zones = [ "eu-west-1a","eu-west-1b","eu-west-1c" ]

    target_group_arns = [ aws_lb_target_group.demo-tg.arn]

    launch_template {
        id = aws_launch_template.demo-lt.id
    }
}

resource "aws_lb_target_group" "demo-tg" {
    name = "terraform-demo-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = "vpc-098619d88bf464cbe"
}

resource "aws_lb" "demo-elb" {
    name = "terraform-demo-elb"
    load_balancer_type = "application"
    security_groups = [ "sg-013ef36435de1738d" ]
    subnets = [ "subnet-0e2604974ab1b723a","subnet-027995a49277edbed","subnet-08fd5ca933492eef7" ]

    tags = {
      "Environment" = "Development"
    }
}

resource "aws_lb_listener" "demo-listener" {
    load_balancer_arn = aws_lb.demo-elb.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.demo-tg.arn
    }
}