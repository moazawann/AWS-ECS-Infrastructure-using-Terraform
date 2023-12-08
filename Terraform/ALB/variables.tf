variable "ALB_subnets_id" {
    description = "The subnets required for the Application Load Balancer"
}

variable "ALB_security_group_id" {
    description = "The security group reuired for the ALB"
  
}

variable "ALB_TG_VPC_id" {
    description = "VPC required for the ALB tagret Group"
}

variable "port" {
  default = 80
}