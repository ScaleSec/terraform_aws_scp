#-----security_controls_scp/vpc/main.tf----#
resource "aws_organizations_policy" "deny_vpc_flow_logs_delete" {
  name        = "Deny Flow Logs Deletion"
  description = "Deny the ability to delete VPC Flow Logs"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "ec2:DeleteFlowLogs",
        "logs:DeleteLogGroup",
        "logs:DeleteLogStream"
      ],
      "Resource": "*"
    }
  ]
 }
CONTENT
}

resource "aws_organizations_policy_attachment" "deny_vpc_flow_logs_delete_attachment" {
  policy_id = "${aws_organizations_policy.deny_vpc_flow_logs_delete.id}"
  target_id = "${var.target_id}"
}
