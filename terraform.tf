terraform {
  backend "s3" {
    bucket = "wy-terraform-state-24"
    key    = "ecommerce-infrastructure/terraform.tfstate"
    region = "ap-southeast-1"
  }
}