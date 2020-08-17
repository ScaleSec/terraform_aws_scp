#-----security_controls_scp/modules/s3/deny_public_access_poins.tf----#

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
