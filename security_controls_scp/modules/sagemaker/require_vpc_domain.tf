#-----security_controls_scp/modules/sagemaker/require_vpc_domain.tf----#

data "aws_iam_policy_document" "require_vpc_domain" {
  statement {
    sid = "RequireVpcDomain"

    actions = [
      "sagemaker:CreateDomain",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

     condition {
      test     = "StringEquals"
      variable = "sagemaker:AppNetworkAccessType"

      values = [
        "PublicInternetOnly",
      ]
    }
  }
}

resource "aws_organizations_policy" "require_vpc_domain_policy" {
  name        = "Require VPC SageMaker Domains."
  description = "Requires all SageMaker Domains to route traffic through VPCs."

  content = data.aws_iam_policy_document.require_vpc_domain.json
}

resource "aws_organizations_policy_attachment" "require_vpc_domain_attachment" {
  policy_id = aws_organizations_policy.require_vpc_domain_policy.id
  target_id = var.target_id
}
