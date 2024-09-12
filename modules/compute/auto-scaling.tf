resource "aws_autoscaling_group" "asg" {
  name                      = "ASG-${var.environment}"
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  availability_zones        = var.asg_azs
  target_group_arns         = [aws_alb_target_group.alb_target_group.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300 # default

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name                          = "TG-${var.environment}"
  port                          = 8080
  load_balancing_algorithm_type = "round_robin"
  target_type                   = "instance"
  protocol_version = "HTTP1"
  protocol         = "HTTP"
  vpc_id           = var.vpc_id

  health_check {
    enabled             = true # default
    healthy_threshold   = 3    # default
    interval            = 30   # default
    matcher             = 200  # default
    path                = var.health_check_path
    port                = "traffic-port" # default
    protocol            = "HTTP"         # default = HTTP
    timeout             = 10             # default
    unhealthy_threshold = 3              # default
  }

    tags = {
    Name = "TargetGroup-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_launch_template" "launch_template" {
  name        = "LT-${var.environment}"
  description = "Ordika ${var.environment} server launch template"

  image_id                             = var.ami
  instance_type                        = var.instance_type
  instance_initiated_shutdown_behavior = "terminate"
  iam_instance_profile {
    name = var.instance_profile
  }
  key_name               = var.ec2_key_name
  vpc_security_group_ids = [aws_security_group.sg_ec2_allow_alb_and_ssh.id]

  monitoring {
    enabled = true
  }

  user_data = filebase64("${path.cwd}/${var.environment}/user-data.sh")
}
