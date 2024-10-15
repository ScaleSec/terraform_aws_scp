#-----security_controls_scp/modules/ec2/require_imdsv2.tf----#

# Require the use of IMDSv2

data "aws_iam_policy_document" "require_imdsv2" {
  statement {
    sid = "RequireEc2InstancesToUseImdsV2"

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
  
  statement {
    sid = "RequireEc2RolesToUseImdsV2"

    actions = [
      "*"
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

    condition {
      test     = "NumericLessThan"
      variable = "ec2:RoleDelivery"

      values = [
        "2.0",
      ]
    }
  }

  statement {
    sid = "DenyDisableImdsV2"

    actions = [
      "ec2:ModifyInstanceMetadataOptions"
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }

  statement {
    sid = "MaxImdsHopLimit"

    actions = [
      "ec2:RunInstances"
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*",
    ]

    effect = "Deny"

    condition {
      test     = "NumericLessThan"
      variable = "ec2:MetadataHttpPutResponseHopLimit"

      values = [
        "1",
      ]
    }
  }
}

resource "aws_organizations_policy" "require_imdsv2_org_policy" {
  name        = "Require IMDSv2 For EC2"
  description = "Requires IMDSv2 for EC2 instances and roles"

  content = data.aws_iam_policy_document.require_imdsv2.json
}

resource "aws_organizations_policy_attachment" "require_imdsv2_org_policy_attachment" {
  policy_id = aws_organizations_policy.require_imdsv2_org_policy.id
  target_id = var.target_id
}
