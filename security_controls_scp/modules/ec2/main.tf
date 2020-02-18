#-----security_controls_scp/modules/ec2/main.tf----#

## Requires a MFA'd account to perform certain EC2 Actions

data "aws_iam_policy_document" "require_mfa_ec2_actions" {
  statement {
    sid = "RequireMFAEC2"

    actions = [
      "ec2:StopInstances",
      "ec2:TerminateInstances",
      "ec2:SendDiagnosticInterrupt",
    ]

    resources = [
      "*",
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

resource "aws_organizations_policy" "require_mfa_ec2_actions" {
  name        = "Require MFA EC2 Actions"
  description = "Require MFA Stopping or Deleting EC2 Instances"

  content = data.aws_iam_policy_document.require_mfa_ec2_actions.json
}

resource "aws_organizations_policy_attachment" "require_mfa_ec2_actions_attachment" {
  policy_id = aws_organizations_policy.require_mfa_ec2_actions.id
  target_id = var.target_id
}

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
