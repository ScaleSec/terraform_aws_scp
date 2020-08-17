#-----security_controls_scp/modules/rds/deny_unencrypted_actions.tf----#

data "aws_iam_policy_document" "deny_unencrypted_rds_actions" {
  statement {
    sid = "DenyUnencryptedRds"

    actions = [
      "rds:CreateDBCluster",
      "rds:CreateDBInstance",
      "rds:RestoreDBClusterFromS3",
      "rds:RestoreDBInstanceFromS3",
      "rds:RestoreDBClusterFromDBSnapshot",
      "rds:RestoreDBClusterToPointInTime",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

    condition {
      test     = "Bool"
      variable = "rds:StorageEncrypted"

      values = [
        "false",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_unencrypted_rds_actions" {
  name        = "Deny Unencrypted RDS Actions"
  description = "Deny any unencrypted RDS action that supports an encryption parameter."

  content = data.aws_iam_policy_document.deny_unencrypted_rds_actions.json
}

resource "aws_organizations_policy_attachment" "deny_unencrypted_rds_actions_attachment" {
  policy_id = aws_organizations_policy.deny_unencrypted_rds_actions.id
  target_id = var.target_id
}