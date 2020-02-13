#-----security_controls_scp/modules/awsconfig/main.tf----#
data "aws_iam_policy_document" "deny_aws_config_rules_delete" {
  statement {
    sid = "DenyConfigRulesDelete"

    actions = [
      "config:DeleteConfigRule",
      "config:DeleteConfigurationRecorder",
      "config:DeleteDeliveryChannel",
      "config:StopConfigurationRecorder",
      "config:DeleteRetentionConfiguration",
      "config:DeleteEvaluationResults",
      "config:DeleteConfigurationAggregator",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }
}

resource "aws_organizations_policy" "deny_aws_config_rules_delete" {
  name        = "Deny Config Rules Delete"
  description = "Deny the ability to delete AWS Config Rules"

  content = data.aws_iam_policy_document.deny_aws_config_rules_delete.json
}

resource "aws_organizations_policy_attachment" "deny_aws_config_rules_delete_attachment" {
  policy_id = aws_organizations_policy.deny_aws_config_rules_delete.id
  target_id = var.target_id
}
