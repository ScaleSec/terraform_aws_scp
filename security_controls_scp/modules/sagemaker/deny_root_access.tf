#-----security_controls_scp/modules/sagemaker/deny_root_access.tf----#

data "aws_iam_policy_document" "deny_root_access" {
  statement {
    sid = "DenyRootAccess"

    actions = [
      "sagemaker:CreateNotebookInstance",
      "sagemaker:UpdateNotebookInstance",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

     condition {
      test     = "StringNotEquals"
      variable = "sagemaker:RootAccess"

      values = [
        "Enabled",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_root_access_policy" {
  name        = "Deny root access to notebooks."
  description = "Denies root access to SageMaker notebook instances."

  content = data.aws_iam_policy_document.deny_root_access.json
}

resource "aws_organizations_policy_attachment" "deny_root_access_attachment" {
  policy_id = aws_organizations_policy.deny_root_access_policy.id
  target_id = var.target_id
}
