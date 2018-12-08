resource "aws_s3_bucket" "0" {
  bucket = "${local.bucket_name}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}
