module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.46.0"

  name = "${var.org_name}-${var.environment}"

  cidr = "10.${var.vpc_cidr_octet}.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.${var.vpc_cidr_octet}.0.0/19", "10.${var.vpc_cidr_octet}.32.0/19", "10.${var.vpc_cidr_octet}.64.0/19"]
  public_subnets  = ["10.${var.vpc_cidr_octet}.96.0/19", "10.${var.vpc_cidr_octet}.128.0/19", "10.${var.vpc_cidr_octet}.164.0/19"]

  enable_nat_gateway   = "${var.enable_nat_gateway}"
  single_nat_gateway   = "${var.single_nat_gateway}"
  enable_vpn_gateway   = "${var.enable_vpn_gateway}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"

  tags {
    Environment = "${var.environment}"
    Terraform   = "true"
    Environment = "${var.environment}"
    Region      = "${var.aws_region}"
  }
}
