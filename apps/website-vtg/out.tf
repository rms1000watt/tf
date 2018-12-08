output "cloudfront_domain" {
  value = "${aws_cloudfront_distribution.0.domain_name}"
}

output "s3_id" {
  value = "${aws_s3_bucket.0.id}"
}

output "s3_arn" {
  value = "${aws_s3_bucket.0.arn}"
}

output "s3_website_endpoint" {
  value = "${aws_s3_bucket.0.website_endpoint}"
}

output "s3_website_domain" {
  value = "${aws_s3_bucket.0.website_domain}"
}

output "s3_bucket_domain_name" {
  value = "${aws_s3_bucket.0.bucket_domain_name}"
}

output "s3_bucket_regional_domain_name" {
  value = "${aws_s3_bucket.0.bucket_regional_domain_name}"
}
