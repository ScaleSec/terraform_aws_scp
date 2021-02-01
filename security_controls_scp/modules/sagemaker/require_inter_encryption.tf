#-----security_controls_scp/modules/sagemaker/require_inter_encryption.tf----#

data "aws_iam_policy_document" "require_inter_container_encryption" {
  statement {
    sid = "RequireInterContainerEncrypt"

    actions = [
      "sagemaker:CreateAutoMLJob",
      "sagemaker:CreateDataQualityJobDefinition",
      "sagemaker:CreateHyperParameterTuningJob",
      "sagemaker:CreateModelBiasJobDefinition",
      "sagemaker:CreateModelExplainabilityJobDefinition",
      "sagemaker:CreateModelQualityJobDefinition",
      "sagemaker:CreateMonitoringSchedule",
      "sagemaker:CreateProcessingJob",
      "sagemaker:CreateTrainingJob",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

     condition {
      test     = "Bool"
      variable = "sagemaker:InterContainerTrafficEncryption"

      values = [
        "false",
      ]
    }
  }
}

resource "aws_organizations_policy" "require_inter_container_encryption_policy" {
  name        = "Require Container2Container Encryption"
  description = "Requires encrypted communication between containers."

  content = data.aws_iam_policy_document.require_inter_container_encryption.json
}

resource "aws_organizations_policy_attachment" "require_inter_container_encryption_attachment" {
  policy_id = aws_organizations_policy.require_inter_container_encryption_policy.id
  target_id = var.target_id
}
