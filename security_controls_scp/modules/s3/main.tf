#-----security_controls_scp/modules/s3/main.tf----#

data "aws_iam_policy_document" "deny_unencrypted_uploads" {
  statement {
    sid = "DenyUnencryptedUploads"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::*/*",
    ]

    effect = "Deny"

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "true",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_unencrypted_uploads" {
  name        = "Deny Unencrypted S3 Uploads"
  description = "Deny the ability to upload an unencrypted S3 Object."

  content = data.aws_iam_policy_document.deny_unencrypted_uploads.json
}

resource "aws_organizations_policy_attachment" "deny_unencrypted_uploads_attachment" {
  policy_id = aws_organizations_policy.deny_unencrypted_uploads.id
  target_id = var.target_id
}

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

data "aws_iam_policy_document" "require_mfa_s3_delete" {
  statement {
    sid = "RequireMFAS3Delete"

    actions = [
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::*/*",
    ]

    effect = "Deny"

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"

      values = [
        "false",
      ]
    }
  }
}

resource "aws_organizations_policy" "require_mfa_s3_delete" {
  name        = "Require MFA To Delete Objects"
  description = "Requires MFA when deleting objects."

  content = data.aws_iam_policy_document.require_mfa_s3_delete.json
}

resource "aws_organizations_policy_attachment" "require_mfa_s3_delete_attachment" {
  policy_id = aws_organizations_policy.require_mfa_s3_delete.id
  target_id = var.target_id
}

data "aws_iam_policy_document" "deny_public_access_points_document" {
  statement {
    sid = "DenyPublicAccessPoints"

    actions = [
      "s3:CreateAccessPoint",
      "s3:PutAccessPointPolicy",
    ]

    resources = [
      "arn:aws:s3:*:*:accesspoint/*",
    ]

    effect = "Deny"

    condition {
      test     = "StringNotEqualsIfExists"
      variable = "s3:AccessPointNetworkOrigin"

      values = [
        "vpc",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_public_access_points_policy" {
  name        = "Deny Public Access Points"
  description = "Denies the ability to create public facing access points."

  content = data.aws_iam_policy_document.deny_public_access_points_document.json
}

resource "aws_organizations_policy_attachment" "deny_public_access_points_attachment" {
  policy_id = aws_organizations_policy.deny_public_access_points_policy.id
  target_id = var.target_id
}