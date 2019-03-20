#-----security_controls_scp/modules/guardduty/main.tf----#
resource "aws_organizations_policy" "deny_guardduty_disassociate" {
  name        = "Deny GuardDuty Disassociation"
  description = "Deny the ability to disassociate a GuardDuty member."

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
            "Effect": "Deny",
            "Action": "guardduty:DisassociateFromMasterAccount",
            "Resource": "*"
    }
  ]
 }
CONTENT
}

resource "aws_organizations_policy_attachment" "deny_guardduty_disassociate_attachment" {
  policy_id = "${aws_organizations_policy.deny_guardduty_disassociate.id}"
  target_id = "${var.target_id}"
}
