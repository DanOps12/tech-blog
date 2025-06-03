resource "aws_s3_bucket" "daniel_tech_blog" {
  bucket = "danieltechblog"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}