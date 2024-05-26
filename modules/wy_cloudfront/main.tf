resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = var.alb_dns_name
    origin_id   = "ALBOrigin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  comment         = "CloudFront Distribution"
  # default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "ALBOrigin"
    viewer_protocol_policy = "redirect-to-https"

    # allowed_methods = ["GET", "HEAD", "OPTIONS"]
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "all" # Make sure cookies are forwarded
      }

      headers = ["Origin", "Referer"] # Forward necessary headers
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  # logging_config {
  #   include_cookies = false
  #   bucket          = aws_s3_bucket.example_bucket.bucket_domain_name
  #   prefix          = "log/"
  # }
}
