resource "aws_cloudwatch_log_group" "Ease-ecs-loggroup" {
  name              = "/ecs/Ease"
  retention_in_days = 7
}

resource "aws_ecs_cluster" "Ease-ECS-Cluster" {
  name = var.Ease-ECS-Cluster-name

    setting {
    name  = "containerInsights"
    value = "enabled"
  }

}

data "aws_ami" "Latest_Amazon_Linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

data "aws_iam_role" "ec2_ecs_role" {
  name = "ecsInstanceRole"
}

data "aws_iam_role" "ec2_task_role" {
  name = "ecsTaskExecutionRole"
}

resource "tls_private_key" "Ease-pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#Creating the new keypair for the instances and saving it the PC
resource "aws_key_pair" "Ease-keypair" {
  key_name   = "easekey"      
  public_key = tls_private_key.Ease-pk.public_key_openssh

  provisioner "local-exec" { 
    command = "echo '${tls_private_key.Ease-pk.private_key_pem}' > ./easekey.pem"
  }
}

resource "aws_launch_configuration" "Ease-LC" {
  image_id        = data.aws_ami.Latest_Amazon_Linux.id
  instance_type   = var.Ease-ECS-Image-type
  security_groups = [var.Launch_Config_Security_group_id]
  key_name        = aws_key_pair.Ease-keypair.key_name
  user_data       = templatefile("instance.sh", { cluster_name = aws_ecs_cluster.Ease-ECS-Cluster.name })
  iam_instance_profile = data.aws_iam_role.ec2_ecs_role.name
}

resource "aws_autoscaling_group" "Ease-autoscaling-group" {
  name                 = "Ease-autoscaling-group"
  launch_configuration = aws_launch_configuration.Ease-LC.name
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = var.Ease-Auto-SG-subnets_ids
}


resource "aws_ecs_service" "Ease-ECS-Service" {
  name = "Ease-ECS-Service"
  cluster         = aws_ecs_cluster.Ease-ECS-Cluster.id
  task_definition = aws_ecs_task_definition.Ease-ECS-Taskdef.arn
  desired_count   = var.desired_count
  
  load_balancer {
    target_group_arn = var.ALB-Target-group-arn
    container_name   = "Ease-con"
    container_port   = var.container_port
}
}

resource "aws_ecs_task_definition" "Ease-ECS-Taskdef" {
  family = "Ease-ECS-Taskdef"
  cpu = var.container_cpu
  memory = var.container_memory
  execution_role_arn = data.aws_iam_role.ec2_task_role.arn
  task_role_arn = data.aws_iam_role.ec2_task_role.arn

 container_definitions = jsonencode([
   {
     name      = "Ease-con"
     image     = var.image_url
     essential = true
     portMappings = [
       {
         containerPort = var.container_port
         hostPort      = var.container_port
         protocol      = "tcp"
       }
     ]

    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-region"        = "ca-central-1",
        "awslogs-group"         = "/ecs/Ease",
        "awslogs-stream-prefix" = "Ease"
      }
    },
   }
 ])
  
  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

}
