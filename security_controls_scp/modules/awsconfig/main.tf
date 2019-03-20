#-----security_controls_scp/modules/awsconfig/main.tf----#
resource "aws_organizations_policy" "deny_aws_config_rules_delete" {
  name        = "Deny Config Rules Delete"
  description = "Deny the ability to delete AWS Config Rules"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "config:DeleteConfigRule",
        "config:DeleteConfigurationRecorder",
        "config:DeleteDeliveryChannel",
        "config:StopConfigurationRecorder",
        "config:DeleteRetentionConfiguration",
        "config:DeleteEvaluationResults",
        "config:DeleteConfigurationAggregator"
      ],
      "Resource": "*"
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "deny_aws_config_rules_delete_attachment" {
  policy_id = "${aws_organizations_policy.deny_aws_config_rules_delete.id}"
  target_id = "${var.target_id}"
}
