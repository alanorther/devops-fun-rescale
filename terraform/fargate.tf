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
      container_cpu                = 512
      container_memory             = 1024
      container_memory_reservation = 1024
      essential                    = true
      container_port               = 5000
      environment = [
          {
              name  = "RDS_ENDPOINT"
              value   = "SOME_RDS_ENDPOINT_VALUE"
          }
      ]
  }
