#-----security_controls_scp/modules/iam/deny_actions_no_mfa.tf----#

#This policy comes from "DenyAllExceptListedIfNoMFA" https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html
data "aws_iam_policy_document" "require_mfa_all" {
  statement {
    sid = "RequireMFA"

    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken",
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

resource "aws_organizations_policy" "require_mfa_all" {
  name        = "Deny all Actions w/o MFA"
  description = "If user does not have MFA, they cannot perform actions"

  content = data.aws_iam_policy_document.require_mfa_all.json
}

resource "aws_organizations_policy_attachment" "require_mfa_all_attachment" {
  policy_id = aws_organizations_policy.require_mfa_all.id
  target_id = var.target_id
}
