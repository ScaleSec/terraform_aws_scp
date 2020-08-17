#-----security_controls_scp/modules/cloudtrail/deny_cloudtrail_actions.tf----#

data "aws_iam_policy_document" "deny_cloudtrail_actions" {
  statement {
    sid = "DenyCloudTrailActions"

    actions = [
      "cloudtrail:DeleteTrail",
      "cloudtrail:PutEventSelectors",
      "cloudtrail:StopLogging",
      "cloudtrail:UpdateTrail",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }
}

resource "aws_organizations_policy" "deny_cloudtrail_actions" {
  name        = "Deny CloudTrail Actions"
  description = "Deny the ability to manipulate CloudTrail"

  content = data.aws_iam_policy_document.deny_cloudtrail_actions.json
}

resource "aws_organizations_policy_attachment" "deny_cloudtrail_actions_attachment" {
  policy_id = aws_organizations_policy.deny_cloudtrail_actions.id
  target_id = var.target_id
}
