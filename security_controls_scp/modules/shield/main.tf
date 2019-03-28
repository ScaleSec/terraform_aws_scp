#-----security_controls_scp/modules/shield/main.tf----#
resource "aws_organizations_policy" "deny_shield_removal" {
  name        = "Deny Shield Deletes"
  description = "Deny users from deleting shield protection"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "shield:DeleteProtection",
                "shield:DeleteSubscription",
                "shield:DisassociateDRTLogBucket",
                "shield:DisassociateDRTRole",
                "shield:UpdateEmergencyContactSettings"
            ],
            "Resource": "*"
        }
     ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "deny_shield_removal_attachment" {
  policy_id = "${aws_organizations_policy.deny_shield_removal.id}"
  target_id = "${var.target_id}"
}
