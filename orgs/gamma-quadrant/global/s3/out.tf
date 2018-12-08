output "web_bucket_domain_name" {
  value = "${aws_s3_bucket.self.bucket_domain_name}"
}
