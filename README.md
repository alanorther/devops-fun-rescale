# Rescale Micro "microservices" Deployment 

This is a automated deployment of a dashboard into AWS using Fargate and RDS.

### Prerequisites

This deployment requires Docker, Terraform, AWSCLI, and a user setup to deploy AWS assets.

Requires that AWS Longer Format Resource IDs are enabled in your AWS account.

### Versions used

Docker version 19.03.5, build 633a0ea

Terraform v0.12.20

aws-cli/1.17.9 Python/2.7.17 Darwin/18.7.0 botocore/1.14.9

### AWS Profile Used

By default this used the default profile in your ~/.aws/credentials file.

To change the profile used, change the profile in the terraform/provider.tf file:

```
$ cat provider.tf
provider "aws" {
  region  = "us-west-2"
  profile = "default"
}
```

### AWS Rescources Built

```
aws_eip
aws_internet_gateway
aws_nat_gateway
aws_route
aws_route_table
aws_route_table_association
aws_subnet
aws_vpc
aws_vpn_gateway
aws_appautoscaling_policy
aws_appautoscaling_target
aws_cloudwatch_metric_alarm
aws_ecs_service
aws_iam_role
aws_iam_role_policy
aws_kms_key
aws_lb
aws_lb_listener
aws_lb_target_group
aws_security_group
aws_ecs_cluster
aws_ecs_task_definition
aws_iam_role_policy_attachment
aws_db_instance
aws_ecr_repository
```

### Get Contanier Running Locally

Run these in the root folder of the repo:

```
docker build -t rescale .
docker container run --publish 8000:5000 --detach --name rescale rescale:latest
```

Run 'docker ps' to find the container ID of the running rescale container:

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS                    NAMES
d0180268a0f2        rescale:latest      "./startup.sh"      About a minute ago   Up About a minute   0.0.0.0:8000->5000/tcp   rescale
```

Use the container ID to login to the container:

```
docker exec -it d0180268a0f2 bash
root@d0180268a0f2:/usr/src/app#
```

You can now explore the container.

## View the portal locally

You can see the portal page in a browser if the container is running at http://localhost:8000

### Deployment Infrastructure

From the repo's root folder, go to the terraform folder and run Terraform.

You need to supply the master password for the PostgreSQL RDS instance.

```
devops-fun-rescale $ cd terraform/
terraform $ terraform apply
var.db_password
  The master password for the PostgreSQL RDS instance

  Enter a value: SuperSecretPassword
```

Terraform will output two bits of information, the Fargate LB and the ECR URL. Copy both.

```
Outputs:

fargate_lb = rescale-lb-1234567.us-west-2.elb.amazonaws.com
repository_url = 123456789012.dkr.ecr.us-west-2.amazonaws.com/rescale
```

### Build and Deploy application container

Go to the root folder of the repo and use the build script with the ECR URL.

```
./build_push_deploy.sh 123456789012.dkr.ecr.us-west-2.amazonaws.com/rescale
```

Now give it some time to build and deploy. You can check that the app is working by visiting the Fargate LB URL in your browser.

```
http://rescale-lb-1234567.us-west-2.elb.amazonaws.com
```

## Built With

* [Docker](https://docs.docker.com/) - Container Application
* [Terraform](https://www.terraform.io/docs/index.html) - IaC
* [AWSCLI](https://aws.amazon.com/cli/) - Used to manage AWS resources

### Time Spent

```
Planning       1
Start Script   1
Build/Deploy   1
Code Changes   2
Terraform
  VPC          2
  ECR          1
  RDS          1
  Fargate      2
Postgres       1
Misc.          1
README.md      1
------------------
Total         14 Hours
```
