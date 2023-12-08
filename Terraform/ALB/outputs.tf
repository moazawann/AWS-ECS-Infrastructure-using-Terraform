output "Ease-ALB-DNS" {
  
  value = aws_alb.Ease-ALB.dns_name
}

output "Ease-ALB-TG-arn" {
  
  value = aws_alb_target_group.Ease-ALB-TG.arn
}