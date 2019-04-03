#-----security_controls_scp/modules/guardduty/main.tf----#
data "aws_iam_policy_document" "deny_guardduty_disassociate" {
  statement {
    sid = "DenyGuardDutyDisassociation"

    actions = [
        "guardduty:DisassociateFromMasterAccount",
      ]
    resources = [
      "*",
    ]
    effect  = "Deny"
  }
}
resource "aws_organizations_policy" "deny_guardduty_disassociate" {
  name        = "Deny GuardDuty Disassociation"
  description = "Deny the ability to disassociate a GuardDuty member."

  content = "${data.aws_iam_policy_document.deny_guardduty_disassociate.json}"
}

resource "aws_organizations_policy_attachment" "deny_guardduty_disassociate_attachment" {
  policy_id = "${aws_organizations_policy.deny_guardduty_disassociate.id}"
  target_id = "${var.target_id}"
}
