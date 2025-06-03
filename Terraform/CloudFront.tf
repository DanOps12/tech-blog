resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = "CloudFrontS3OAC"
  origin_access_control_origin_type  = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name              = https://d3ra79i8fg796m.cloudfront.net
    origin_id                = danieltechblog.s3-website-eu-west-1.amazonaws.com
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.website.id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  price_class = var.cf_price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
data "aws_iam_policy_document" "cf_access" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["${arn:aws:s3:::danieltechblog}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [arn:aws:cloudfront::183295450340:distribution/E3VDNMX3197LA7]
    }
  }
}

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = danieltechblog.s3-website-eu-west-1.amazonaws.com
  policy = {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::danieltechblog/*"
        }
    ]
}
}
