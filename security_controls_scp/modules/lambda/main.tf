#-----security_controls_scp/modules/lambda/main.tf----#

##############################################################################
## Requires lambda functions to be deployed in a customer owned VPC.        ##
## By default, lambda functions are deployed in a VPC owned by AWS / Lambda ##
##############################################################################


data "aws_iam_policy_document" "require_vpc_lambda" {
  statement {
    sid = "RequireLambdaInVpc"

    actions = [
      "lambda:CreateFunction",
      "lambda:UpdateFunctionConfiguration"
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

    condition {

      test    = "Null"
      variable = "lambda:VpcIds"
      values = [
        "true",
      ]
    }
  }
}

resource "aws_organizations_policy" "require_vpc_lambda" {
  name        = "Lambda in Customer VPC"
  description = "Requires lambdas to be deployed in a customer owned VPC."

  content = data.aws_iam_policy_document.require_vpc_lambda.json
}

resource "aws_organizations_policy_attachment" "require_vpc_lambda_attachment" {
  policy_id = aws_organizations_policy.require_vpc_lambda.id
  target_id = var.target_id
}
