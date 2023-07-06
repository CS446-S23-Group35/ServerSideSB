variable "aws_profile" {
  description = "AWS profile to use"
  default     = "default"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR value"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
  default     = "10.0.1.0/24"
}
 
variable "private_subnet_cidrs" {
  type        = string
  description = "Private Subnet CIDR values"
  default     = "10.0.2.0/24"
}

variable "bastion_key_pair" {
  type        = string
  description = "Bastion key pair name"
}
