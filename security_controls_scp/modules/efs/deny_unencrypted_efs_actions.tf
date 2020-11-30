#-----security_controls_scp/modules/efs/deny_unencrypted_efs_actions.tf----#

data "aws_iam_policy_document" "deny_unencrypted_efs_actions" {
  statement {
    sid = "DenyUnencryptedEfs"

    actions = [
      "elasticfilesystem:CreateFileSystem"
    ]

    resources = [
      "*",
    ]

    effect = "Allow"

    condition {
      test     = "Bool"
      variable = "elasticfilesystem:Encrypted"

      values = [
        "true",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_unencrypted_efs_actions" {
  name        = "Deny Unencrypted EFS Actions"
  description = "Deny any unencrypted EFS action that supports an encryption parameter."

  content = data.aws_iam_policy_document.deny_unencrypted_efs_actions.json
}

resource "aws_organizations_policy_attachment" "deny_unencrypted_efs_actions_attachment" {
  policy_id = aws_organizations_policy.deny_unencrypted_efs_actions.id
  target_id = var.target_id
}