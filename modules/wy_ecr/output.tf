output "ecr_repository_uri" {
  value = aws_ecr_repository.ecr.repository_url
}