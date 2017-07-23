data "aws_iam_policy_document" "site_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket" "site_bucket" {
  bucket        = "${var.s3_bucket_name}"
  acl           = ""
  force_destroy = false

  policy = "${data.aws_iam_policy_document.site_policy.json}"
}
