#-----security_controls_scp/modules/ec2/require_imdsv2.tf----#

# Require the use of IMDSv2

data "aws_iam_policy_document" "require_imdsv2" {
  statement {
    sid = "RequireIMDSv2"

    actions = [
      "ec2:RunInstances"
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*",
    ]

    effect = "Deny"

    condition {
      test     = "StringNotEquals"
      variable = "ec2:MetadataHttpTokens"

      values = [
        "required",
      ]
    }
  }
}

resource "aws_organizations_policy" "require_imdsv2_org_policy" {
  name        = "Require IMDSv2 For EC2"
  description = "Requires the use of IMDSv2 for newly launched EC2s"

  content = data.aws_iam_policy_document.require_imdsv2.json
}

resource "aws_organizations_policy_attachment" "require_imdsv2_org_policy_attachment" {
  policy_id = aws_organizations_policy.require_imdsv2_org_policy.id
  target_id = var.target_id
}
