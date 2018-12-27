resource "aws_cloudtrail" "foobar" {
  name                          = "account-log"
  s3_bucket_name                = "${aws_s3_bucket.cloudtrail_bucket.id}"
  include_global_service_events = true
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket        = "${var.cloudtrail-bucket-name}"
  force_destroy = true
  encrypt       = true

  lifecycle_rule {
    id      = "log"
    enabled = true

    prefix = ""

    tags = {
      "rule"      = "log"
      "autoclean" = "true"
    }

    transition {
      days          = 1
      storage_class = "GLACIER"
    }

    expiration {
      days = 45
    }
  }

  versioning {
    mfa_delete = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.cloudtrail-bucket-name}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.cloudtrail-bucket-name}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}
