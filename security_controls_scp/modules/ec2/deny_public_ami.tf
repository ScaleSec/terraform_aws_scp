#-----security_controls_scp/modules/ec2/deny_public_ami.tf----#

## Denies Users from launching EC2s from Public AMIs

data "aws_iam_policy_document" "deny_ec2_public_ami" {
  statement {
    sid = "DenyEc2PublicAMI"

    actions = [
      "ec2:RunInstances",
    ]

    resources = [
      "arn:aws:ec2:*::image/*",
    ]

    effect = "Deny"

    condition {
      test     = "Bool"
      variable = "ec2:Public"

      values = [
        "true",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_ec2_public_ami" {
  name        = "Deny EC2 Public AMI"
  description = "Denies users the ability to launch EC2 instances with public AMIs."

  content = data.aws_iam_policy_document.deny_ec2_public_ami.json
}

resource "aws_organizations_policy_attachment" "deny_ec2_public_ami_attachment" {
  policy_id = aws_organizations_policy.deny_ec2_public_ami.id
  target_id = var.target_id
}
