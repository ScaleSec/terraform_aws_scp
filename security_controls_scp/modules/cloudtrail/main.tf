#-----security_controls_scp/cloudtrail/main.tf----#
resource "aws_organizations_policy" "deny_cloudtrail_delete" {
  name        = "Deny CloudTrail Delete"
  description = "Deny the ability to delete CloudTrails"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Effect": "Deny",
    "Action": "cloudtrail:DeleteTrail",
    "Resource": "*"
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "deny_cloudtrail_delete_attachment" {
  policy_id = "${aws_organizations_policy.deny_cloudtrail_delete.id}"
  target_id = "${var.target_id}"
}
