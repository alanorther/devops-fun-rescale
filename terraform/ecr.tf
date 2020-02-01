resource "aws_ecr_repository" "rescale" {
  name = "rescale"
}

output "repository_url" {
  description = "The URL of the ECR repository."
  value = aws_ecr_repository.rescale.repository_url
}
