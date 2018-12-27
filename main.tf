locals {
  full_bucket_name = "${var.repository_name}-${var.bucket_name}"
}

resource "aws_s3_bucket" "helm-chart-repository" {
  bucket = "${local.full_bucket_name}"

  # Allows read access to objects not uploaded by the bucket owner; see <https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteAccessPermissionsReqd.html> for details
  acl = "public-read"

  force_destroy = "${var.is_forcing_destroy}"

  logging {
    target_bucket = "${var.log_bucket_id}"
    target_prefix = "${var.repository_name}/${local.full_bucket_name}/"
  }

  versioning {
    enabled = "${var.is_versioning_enabled}"
  }

  website {
    index_document = "index.html"
  }

  tags {
    Terraform             = true
    Helm-Chart-Repository = true
  }
}

data "aws_iam_policy_document" "helm-chart-repository-policy-document" {
  # Minimum permission required for website access; see <https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteAccessPermissionsReqd.html> for details
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.helm-chart-repository.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "helm-chart-repository-bucket-policy" {
  bucket = "${aws_s3_bucket.helm-chart-repository.id}"
  policy = "${data.aws_iam_policy_document.helm-chart-repository-policy-document.json}"
}

resource "aws_s3_bucket_object" "helm-chart-repository-index-html" {
  bucket       = "${local.full_bucket_name}"
  key          = "index.html"
  content      = "${data.template_file.helm-chart-repository-index-html.rendered}"
  etag         = "${md5("${data.template_file.helm-chart-repository-index-html.rendered}")}"
  content_type = "text/html"
}
