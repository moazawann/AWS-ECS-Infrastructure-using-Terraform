variable "vpc-cidr_block" {
  default = "10.0.0.0/20"
}

#subnets cidr's
variable "public-subnet-1a-cidr" {
  default = "10.0.0.0/21"
}

variable "public-subnet-1b-cidr" {
  default = "10.0.8.0/21"
}

#subnet availbility zones
variable "public-subnet-1a-az" {
  default = "ca-central-1a"
}

variable "public-subnet-1b-az" {

  default = "ca-central-1b"
}