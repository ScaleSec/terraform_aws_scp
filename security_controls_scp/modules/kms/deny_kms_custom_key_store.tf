#-----security_controls_scp/modules/kms/deny_kms_custom_key_store.tf----#

data "aws_iam_policy_document" "deny_kms_custom_key_store" {
  statement {
    sid = "DenyKmsCustomKeyStore"

    actions = [
      "kms:CreateCustomKeyStore",
      "kms:UpdateCustomKeyStore",
      "kms:ConnectCustomKeyStore",
      "kms:DisconnectCustomKeyStore",
      "kms:DeleteCustomKeyStore",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }
}

resource "aws_organizations_policy" "deny_kms_custom_key_store" {
  name        = "Deny KMS custom key store"
  description = "Deny the ability to use KMS custom key store

  content = data.aws_iam_policy_document.deny_kms_custom_key_store.json
}

resource "aws_organizations_policy_attachment" "deny_kms_custom_key_store_attachment" {
  policy_id = aws_organizations_policy.deny_kms_custom_key_store.id
  target_id = var.target_id
}
