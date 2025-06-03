
resource "aws_s3_bucket" "website" {
  bucket = danieltechblog
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = danieltechblog

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
