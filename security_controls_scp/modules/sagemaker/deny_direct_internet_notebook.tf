#-----security_controls_scp/modules/sagemaker/deny_direct_internet_notebook.tf----#

data "aws_iam_policy_document" "deny_direct_internet_notebook" {
  statement {
    sid = "DenyDirectInternetNotebook"

    actions = [
      "sagemaker:CreateNotebookInstance",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

     condition {
      test     = "StringNotEquals"
      variable = "sagemaker:DirectInternetAccess"

      values = [
        "Disabled",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_direct_internet_notebook_policy" {
  name        = "Require VPC Notebooks"
  description = "Requires all SageMaker Notebooks to route traffic through VPCs."

  content = data.aws_iam_policy_document.deny_direct_internet_notebook.json
}

resource "aws_organizations_policy_attachment" "deny_direct_internet_notebook_attachment" {
  policy_id = aws_organizations_policy.deny_direct_internet_notebook_policy.id
  target_id = var.target_id
}
