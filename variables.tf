variable "vpc_cidr" {
  description = "vpc_cidr_value"
  type = string
}

variable "public_subnets" {
  default = "public_subnets_cidr_value"
  type = list(string)
}