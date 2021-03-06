module "ecs-fargate" {
      source              = "git@github.com:/cn-terraform/terraform-aws-ecs-fargate"
      name_preffix        = "rescale"
      profile             = "default"
      region              = "us-west-2"
      vpc_id              = module.vpc.vpc_id
      availability_zones  = module.vpc.azs
      public_subnets_ids  = module.vpc.public_subnets
      private_subnets_ids = module.vpc.private_subnets
      container_name               = "rescale"
      container_image              = "363321713206.dkr.ecr.us-west-2.amazonaws.com/rescale:latest"
      container_cpu                = 1024
      container_memory             = 2048
      container_memory_reservation = 2048
      essential                    = true
      container_port               = 5000
      lb_health_check_path         = "/health_check"
      environment = [
          {
              name  = "DB_HOSTNAME"
              value   = aws_db_instance.postgres_rds.address
          },
          {
              name = "DB_USERNAME"
              value = "postgres"
          },
          {
              name = "DB_PASSWORD"
              value = var.db_password
          }
      ]
  }

output "fargate_lb" {
  description = "The DNS name for the load-balancer to reach the application."
  value = module.ecs-fargate.lb_dns_name
}
