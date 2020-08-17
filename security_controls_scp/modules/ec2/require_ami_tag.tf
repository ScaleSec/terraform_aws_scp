#-----security_controls_scp/modules/ec2/require_ami_tag.tf----#

## Requires a resource tag on an AMI to launch an EC2 (ABAC)

data "aws_iam_policy_document" "require_ami_tag_document" {
  statement {
    sid = "RequireAMIResourceTag"

    actions = [
      "ec2:RunInstances"
    ]

    resources = [
      "arn:aws:ec2:*::image/ami-*"
    ]

    effect = "Deny"

    condition {
      test     = "StringNotEqualsIgnoreCase"
      variable = "ec2:ResourceTag/${var.ami_tag_key}"

      values = [
        var.ami_tag_value
      ]
    }
  }
}

resource "aws_organizations_policy" "require_ami_tag_policy" {
  name        = "Require AMI Tags for EC2."
  description = "Requires a specific Resource Tag Key/Value pair in order to deploy EC2 instances."

  content = data.aws_iam_policy_document.require_ami_tag_document.json
}

resource "aws_organizations_policy_attachment" "require_ami_tag_attachment" {
  policy_id = aws_organizations_policy.require_ami_tag_policy.id
  target_id = var.target_id
}
