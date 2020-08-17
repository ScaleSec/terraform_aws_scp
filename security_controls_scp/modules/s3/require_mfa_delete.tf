#-----security_controls_scp/modules/s3/require_mfa_delete.tf----#

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
