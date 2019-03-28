#-----security_controls_scp/modules/organizations/main.tf----#
resource "aws_organizations_policy" "deny_orgs_leave" {
  name        = "Deny Org Account Leave"
  description = "Deny an Account from Leaving an AWS Org"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "organizations:LeaveOrganization",
      "Resource": "*",
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "deny_orgs_leave_attachment" {
  policy_id = "${aws_organizations_policy.deny_orgs_leave.id}"
  target_id = "${var.target_id}"
}