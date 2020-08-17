#-----security_controls_scp/modules/ec2/restrict_ami_owner.tf----#

## Locks down which AMIs can be launched

data "aws_iam_policy_document" "restrict_ec2_ami_document" {
  statement {
    sid = "RestrictEC2AMI"

    actions = [
      "ec2:RunInstances"
    ]

    resources = [
      "arn:aws:ec2:*::image/ami-*"
    ]

    effect = "Deny"

    condition {
      test     = "StringNotEquals"
      variable = "ec2:Owner"

      values = [
        var.ami_creator_account
      ]
    }

  }
}

resource "aws_organizations_policy" "restrict_ec2_ami_policy" {
  name        = "Retrict EC2 AMIs"
  description = "Restricts the AMIs that can be launched to the AMI creator account."

  content = data.aws_iam_policy_document.restrict_ec2_ami_document.json
}

resource "aws_organizations_policy_attachment" "restrict_ec2_ami_attachment" {
  policy_id = aws_organizations_policy.restrict_ec2_ami_policy.id
  target_id = var.target_id
}

