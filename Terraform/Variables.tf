variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "danieltechblog"
  type        = string
}

variable "domain_name" {
  description = "d3ra79i8fg796m.cloudfront.net"
  type        = string
}
