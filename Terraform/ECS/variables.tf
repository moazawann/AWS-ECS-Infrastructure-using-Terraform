variable "Ease-ECS-Cluster-name" {
    default = "Ease-ECS-Cluster"
  
}

variable "Ease-ECS-Image-type" {
    default = "t2.micro"
  
}

variable "Launch_Config_Security_group_id" {
description = "Security group required for the Launch Configuration"
  
}

variable "Ease-Auto-SG-subnets_ids" {
  
  description = "Subnets required for the Auto Scaling Group"
}

variable "ALB-Target-group-arn" {
  description = "Target group required for the ECS Service"
}

variable "desired_count" {
  description = "desired count of instances in the service"
}

variable "container_cpu" {
  default = 512
}
variable "container_memory" {
  default = 256
}

variable "image_url" {
  description = "Url of the image from the dockerhub or ECR etc"
}

variable "container_port" {
  default = 80
}
