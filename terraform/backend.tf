terraform {
  backend "s3" {
    bucket = "rescale-terraform"
    key = "rescale-terraform/rescale"
    region = "us-west-2"
    encrypt = true
    dynamodb_table = ""
  }
}
