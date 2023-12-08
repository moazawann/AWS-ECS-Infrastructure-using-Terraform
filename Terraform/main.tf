terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {

    region = "ca-central-1"
  
}

module "VPC" {
    source = "./VPC"
    vpc-cidr_block = "10.0.0.0/20"
    public-subnet-1a-cidr = "10.0.0.0/21"
    public-subnet-1b-cidr = "10.0.8.0/21"
    public-subnet-1a-az = "ca-central-1a"
    public-subnet-1b-az = "ca-central-1b"

}

module "ALB" {
    source = "./ALB"
    ALB_subnets_id = module.VPC.public_subnet_ids
    ALB_security_group_id = module.VPC.security_group_id
    ALB_TG_VPC_id = module.VPC.vpc_id
    port = 3000
}


module "ECS" {
    source = "./ECS"
    Ease-ECS-Cluster-name = "Ease-ECS-Cluster"
    Ease-ECS-Image-type = "t2.micro"
    Launch_Config_Security_group_id = module.VPC.security_group_id
    Ease-Auto-SG-subnets_ids = module.VPC.public_subnet_ids
    ALB-Target-group-arn = module.ALB.Ease-ALB-TG-arn
    image_url = "759910503519.dkr.ecr.ca-central-1.amazonaws.com/ease"
    container_cpu = 512
    container_memory = 256
    container_port = 3000
    desired_count = 2
  
}

output "dns" {
    value = module.ALB.Ease-ALB-DNS
  
}