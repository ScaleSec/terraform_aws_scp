#-----security_controls_scp/modules/iam/main.tf----#
resource "aws_organizations_policy" "require_mfa_all" {
  name        = "Deny all Actions w/o MFA"
  description = "If user does not have MFA, they cannot perform actions"
#This policy comes from "DenyAllExceptListedIfNoMFA" https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html
  content = <<CONTENT
        {
            "Effect": "Deny",
            "NotAction": [
                "iam:CreateVirtualMFADevice",
                "iam:EnableMFADevice",
                "iam:GetUser",
                "iam:ListMFADevices",
                "iam:ListVirtualMFADevices",
                "iam:ResyncMFADevice",
                "sts:GetSessionToken"
            ],
            "Resource": "*",
            "Condition": {
                "BoolIfExists": {
                    "aws:MultiFactorAuthPresent": "false"
                }
            }
        }
    ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "require_mfa_all_attachment" {
  policy_id = "${aws_organizations_policy.require_mfa_all.id}"
  target_id = "${var.target_id}"
}
