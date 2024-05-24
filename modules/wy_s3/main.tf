resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = {
    Name        = "${var.project_name}-appdata-bucket"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
# resource "aws_s3_bucket_ownership_controls" "bucket_ownership_controls" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   rule {
#     object_ownership = "BucketOwnerEnforced"

#   }
# }
# resource "aws_s3_bucket_acl" "bucket_acl" {
#   depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership_controls]

#   bucket = aws_s3_bucket.s3_bucket.id
#   acl    = "private"
# }