#-----security_controls_scp/modules/s3/main.tf----#
resource "aws_organizations_policy" "deny_unencrypted_uploads" {
  name        = "Deny Unencrypted S3 Uploads"
  description = "Deny the ability to upload an unencrypted S3 Object."

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::*/*",
      "Condition": {
        "Null": {
          "s3:x-amz-server-side-encryption": true
        }
      }
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "deny_unencrypted_uploads_attachment" {
  policy_id = "${aws_organizations_policy.deny_unencrypted_uploads.id}"
  target_id = "${var.target_id}"
}

resource "aws_organizations_policy" "deny_unsecure_s3_requests" {
  name        = "Deny Unsecure SSL Requests to S3"
  description = "Deny all non-ssl requests to s3 buckets"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::*/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "deny_unsecure_s3_requests_attachment" {
  policy_id = "${aws_organizations_policy.deny_unsecure_s3_requests.id}"
  target_id = "${var.target_id}"
}

resource "aws_organizations_policy" "require_mfa_s3_delete" {
  name        = "Require MFA To Delete Objects"
  description = "Requires MFA when deleting objects."

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "s3:DeleteObject",
      "Resource": "arn:aws:s3:::*/*",
      "Condition": {
        "BoolIfExists": {
          "aws:MultiFactorAuthPresent": "false"
        }
      }
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "require_mfa_s3_delete_attachment" {
  policy_id = "${aws_organizations_policy.require_mfa_s3_delete.id}"
  target_id = "${var.target_id}"
}