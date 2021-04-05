#-----security_controls_scp/modules/sagemaker/require_kms_cmks.tf----#

data "template_file" "require_kms_cmks_policy" {
    template = file("./templates/require_kms_cmks.json")
}

resource "aws_organizations_policy" "require_kms_cmks_policy" {
    name        = "Comprehend require KMS CMKs"
    description = "Requires all applicable Comprehend APIs use KMS CMKs."

    content = data.template_file.require_kms_cmks.rendered
}

resource "aws_organizations_policy_attachment" "require_kms_cmks_attachment" {
    policy_id = aws_organizations_policy.require_kms_cmks_policy.id
    target_id = var.target_id
}
