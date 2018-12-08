resource "aws_cloudfront_distribution" "0" {
  origin {
    domain_name = "${aws_s3_bucket.0.bucket_domain_name}"
    origin_id   = "web-origin-1"
  }

  enabled             = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  aliases = ["valkyriebrands.com", "www.valkyriebrands.com"]

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

    lambda_function_association {
      event_type   = "origin-request"
      lambda_arn   = "${aws_lambda_function.0.qualified_arn}"
      include_body = false
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:401319614350:certificate/686284c9-7adb-4266-b250-36403defd9f7"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
