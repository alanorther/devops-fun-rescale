module "vpc" {
  source = "git@github.com:/terraform-aws-modules/terraform-aws-vpc"

  name = "rescale"
  cidr = "192.168.120.0/21"
  enable_dns_hostnames = true

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["192.168.120.0/24", "192.168.121.0/24", "192.168.122.0/24"]
  public_subnets  = ["192.168.123.0/24", "192.168.124.0/24", "192.168.125.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "rescale"
  }
}
