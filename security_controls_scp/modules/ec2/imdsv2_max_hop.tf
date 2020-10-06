#-----security_controls_scp/modules/ec2/imdsv2_max_hop.tf----#

# Limits the amount of hops an IMDSv2 token can make

data "aws_iam_policy_document" "imdsv2_max_hop" {
  statement {
    sid = "IMDSv2MaxHopLimit"

    actions = [
      "ec2:RunInstances"
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*",
    ]

    effect = "Deny"

    condition {
      test     = "NumericGreaterThan"
      variable = "ec2:MetadataHttpPutResponseHopLimit"

      values = [
        var.imdsv2_max_hop,
      ]
    }
  }
}

resource "aws_organizations_policy" "imdsv2_max_hop_org_policy" {
  name        = "Limits the amount of IMDSv2 hops"
  description = "Limits the amount of hops an IMDSv2 token can make."

  content = data.aws_iam_policy_document.imdsv2_max_hop.json
}

resource "aws_organizations_policy_attachment" "imdsv2_max_hop_org_policy_attachment" {
  policy_id = aws_organizations_policy.imdsv2_max_hop_org_policy.id
  target_id = var.target_id
}