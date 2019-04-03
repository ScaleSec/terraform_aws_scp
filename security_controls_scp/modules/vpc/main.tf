#-----security_controls_scp/modules/vpc/main.tf----#

data "aws_iam_policy_document" "deny_vpc_flow_logs_delete" {
  statement {
    sid = "DenyVpcFlowDelete"

    actions = [
      "ec2:DeleteFlowLogs",
      "logs:DeleteLogGroup",
      "logs:DeleteLogStream",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }
}

resource "aws_organizations_policy" "deny_vpc_flow_logs_delete" {
  name        = "Deny Flow Logs Deletion"
  description = "Deny the ability to delete VPC Flow Logs"

  content = "${data.aws_iam_policy_document.deny_vpc_flow_logs_delete.json}"
}

resource "aws_organizations_policy_attachment" "deny_vpc_flow_logs_delete_attachment" {
  policy_id = "${aws_organizations_policy.deny_vpc_flow_logs_delete.id}"
  target_id = "${var.target_id}"
}
