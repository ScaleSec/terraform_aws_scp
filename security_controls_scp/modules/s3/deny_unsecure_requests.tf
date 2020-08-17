#-----security_controls_scp/modules/s3/deny_unsecure_requests.tf----#

data "aws_iam_policy_document" "deny_unsecure_s3_requests" {
  statement {
    sid = "DenyNoTLSRequests"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::*/*",
    ]

    effect = "Deny"

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"

      values = [
        "false",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_unsecure_s3_requests" {
  name        = "Deny Unsecure SSL Requests to S3"
  description = "Deny all non-ssl requests to s3 buckets"

  content = data.aws_iam_policy_document.deny_unsecure_s3_requests.json
}

resource "aws_organizations_policy_attachment" "deny_unsecure_s3_requests_attachment" {
  policy_id = aws_organizations_policy.deny_unsecure_s3_requests.id
  target_id = var.target_id
}

