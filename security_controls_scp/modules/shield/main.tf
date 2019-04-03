#-----security_controls_scp/modules/shield/main.tf----#

data "aws_iam_policy_document" "deny_shield_removal" {
  statement {
    sid = "DenyShieldlRemoval"

    actions = [
      "shield:DeleteProtection",
      "shield:DeleteSubscription",
      "shield:DisassociateDRTLogBucket",
      "shield:DisassociateDRTRole",
      "shield:UpdateEmergencyContactSettings",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }
}

resource "aws_organizations_policy" "deny_shield_removal" {
  name        = "Deny Shield Deletes"
  description = "Deny users from deleting shield protection"

  content = "${data.aws_iam_policy_document.deny_shield_removal.json}"
}

resource "aws_organizations_policy_attachment" "deny_shield_removal_attachment" {
  policy_id = "${aws_organizations_policy.deny_shield_removal.id}"
  target_id = "${var.target_id}"
}
