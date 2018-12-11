variable "vpc_cidr_octet" {
  description = "Second octet for /16 cidr block for VPC"
}

variable "enable_nat_gateway" {
  default = false
}

variable "single_nat_gateway" {
  default = false
}

variable "enable_vpn_gateway" {
  default = false
}

variable "enable_dns_hostnames" {
  default = true
}
