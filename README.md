
# AWS ECS Infrastructure using Terraform

Design and implement an automated infrastructure deployment using Terraform on AWS, utilizing ECS for container orchestration. Additionally, create a simple API and integrate it with the deployed nfrastructure.


## prerequisites

- [Docker (install in your pc)](https://docs.docker.com/)
- [AWS CLI (install in your pc)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Terraform (install in your pc)](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


After installing the prerequisites , Now configure the aws cli with your aws account with necessory credentials:




Open the terminal and run:

```bash
aws configure
```
After configuring, just test it using:

```bash
aws s3 ls
```

## Clone the Repository

```bash
git clone https://github.com/moazawan2002/Ease-Assignment.git
```

Go to the project directory

```bash
cd Ease-Assignment
```
## 1. Create an ECR repository

- Go to your AWS Mangement Concole
- Go to ECR (Elastic Container Registory)
- Create a private repository with any name (eg: ease)



## 2. Dockerizing the API and pushing it to ECR

- Go to the **Docker** dicrectory

```bash
cd Docker
```
- Go to the **AWS ECS** and select the repository created before

![App Screenshot](/img/ECS_repo.png)

- Click on **View push commands**

![App Screenshot](/img/push_commands.png)

- Run the first **3 Commands**
- After **building the docker image** and before **pushing** it to the ECR Registory, just run the image locally to check that its working fine

```bash
docker run -d -p 3000:3000 ease
```
![App Screenshot](/img/docker_local_run.png)

- Run the push command in the **Docker dicrectory**

- **Copy** the **Image URI** from the ECR repository


## 3. Create the Infrastructure using Terraform

## Infrastruture Block Diagram
![App Screenshot](/img/ease-block%20diagram%20(1).png)


## Recources Created using Terraform

#### VPC Module

| resources | Description                |
| :-------- |  ------------------------- |
| `vpc` | vpc used for all the Recources |
| `subnets` |   2 public subnets within the vpc|
| `internet gateway` |    igw for the vpc |
| `route tables` |    will create route for the subnets with igw |
| `security group` |   will be used by  application load balancer and ECS cluster |

#### ALB (Application Load Balancer module) Module

| resources | Description                |
| :-------- |  ------------------------- |
| `alb` | alb to distribute traffic to ecs service instances |
| `alb target group` |  target group of alb where instances will be registered|
| `alb listener` |    listen for the given ports and their health checks|


#### ECS (Elastic Container Serivce) Module

| resources | Description                |
| :-------- |  ------------------------- |
| `ecs cluster` | cluster where all the instances , services will be launched |
| `aws ami` |  latest amazon linux for ecs instances|
| `aws key pair` | key pair for the instances |
| `launch configuration` | configurations of the ec2 instance ami,type,key,userdata |
| `auto scaling group` |  group to define min max desired instances |
| `ecs service` |  service within the cluster to look for the task definations and desired count of instances |
| `ecs task defination` |  defining the specs of containers and intergtion of logs to cloud watch of containers|
| `cloudwatch log group, cloudwatch ` |  container logs, container insights |




- Go to the **Terraform** dicrectory
```bash
cd Terraform
```

- Open the file **main.tf** 
- change any configurations you want in main.tf, **eg : aws region , vpc cidrs , names, continer specs , desired count etc**
- Paste the **Image URI** that we copied before in the ECS module 

![App Screenshot](/img/image_uri.png)

- Enter the following commands to **create** the Infrastructure

```bash
terraform init
```
```bash
terraform plan
```
```bash
terraform apply
```

- For **destroying** the Infrastructure
```bash
terraform destroy
```

