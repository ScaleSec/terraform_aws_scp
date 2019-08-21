#-----security_controls_scp/modules/ec2/main.tf----#
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

  content = "${data.aws_iam_policy_document.require_mfa_ec2_actions.json}"
}

resource "aws_organizations_policy_attachment" "require_mfa_ec2_actions_attachment" {
  policy_id = "${aws_organizations_policy.require_mfa_ec2_actions.id}"
  target_id = "${var.target_id}"
}
