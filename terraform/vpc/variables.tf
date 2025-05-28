variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
  validation {
    condition     = length(var.azs) >= 2
    error_message = "At least 2 availability zones must be specified for high availability."
  }
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  validation {
    condition     = length(var.private_subnets) == length(var.azs)
    error_message = "Number of private subnets must match the number of availability zones."
  }
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  validation {
    condition     = length(var.public_subnets) == length(var.azs)
    error_message = "Number of public subnets must match the number of availability zones."
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

