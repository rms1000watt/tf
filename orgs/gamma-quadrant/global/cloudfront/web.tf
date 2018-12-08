resource "aws_cloudfront_distribution" "web" {
  origin {
    domain_name = "${data.terraform_remote_state.s3.web_bucket_domain_name}"
    origin_id   = "web-origin-1"
  }

  enabled             = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  aliases = ["gammaquadrant.io", "www.gammaquadrant.io"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "web-origin-1"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:940942477141:certificate/8945cfa9-9410-4b9c-bedb-fdfd81cc40d1"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
