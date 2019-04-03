#-----security_controls_scp/modules/organizations/main.tf----#

data "aws_iam_policy_document" "deny_orgs_leave" {
  statement {
    sid = "DenyOrgLeave"

    actions = [
      "organizations:LeaveOrganization",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }
}

resource "aws_organizations_policy" "deny_orgs_leave" {
  name        = "Deny Org Account Leave"
  description = "Deny an Account from Leaving an AWS Org"

  content = "${data.aws_iam_policy_document.deny_orgs_leave.json}"
}

resource "aws_organizations_policy_attachment" "deny_orgs_leave_attachment" {
  policy_id = "${aws_organizations_policy.deny_orgs_leave.id}"
  target_id = "${var.target_id}"
}
