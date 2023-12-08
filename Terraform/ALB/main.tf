
resource "aws_alb" "Ease-ALB" {
  name               = "Ease-ALB"
  load_balancer_type = "application"
  subnets            = var.ALB_subnets_id
  security_groups    = [var.ALB_security_group_id]
  internal           = false
  tags = {
    Name    = "Ease-ALB"
    Project = "Ease-ALB"
  }
}

resource "aws_alb_target_group" "Ease-ALB-TG" {
  name        = "Ease-ALB-TG"
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.ALB_TG_VPC_id
  target_type = "instance"
}

resource "aws_alb_listener" "Ease-ALB-listener" {
  load_balancer_arn = aws_alb.Ease-ALB.arn
  port              = var.port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.Ease-ALB-TG.arn
    type             = "forward"
  }

}