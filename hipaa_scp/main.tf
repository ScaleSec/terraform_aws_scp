#-----hipaa_scp/main.tf-----#

provider "aws" {
  region                  = "${var.aws_region}"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.customprofile}"
}

# The below approved services are based off the list located here: https://aws.amazon.com/compliance/hipaa-eligible-services-reference/
resource "aws_organizations_policy" "allow_hipaa_services" {
  name        = "Allow HIPAA Services"
  description = "Only allow HIPAA services as of 3/5/2019"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Effect": "Allow",
    "Action": [
    "amplify:*",
    "apigateway:*",
    "appsync:*",
    "athena:*",
    "autoscaling:*",
    "backup:*",
    "batch:*",
    "acm:*",
    "cloudformation:*",
    "cloudfront:*",
    "cloudhsm:*",
    "cloudtrail:*",
    "cloudwatch:*",
    "codebuild:*",
    "codecommit:*",
    "codedeploy:*",
    "cognito-identity:*",
    "cognito-idp:*",
    "cognito-sync:*",
    "comprehendmedical:*",
    "config:*",
    "connect:*",
    "datasync:*",
    "directconnect:*",
    "dms:*",
    "dynamodb:*",
    "ec2:*",
    "ecr:*",
    "ecs:*",
    "elasticbeanstalk:*",
    "elasticfilesystem:*",
    "eks:*",
    "elasticloadbalancing:*",
    "elasticmapreduce:*",
    "es:*",
    "events:*",
    "firehose:*",
    "fms:*",
    "freertos:*",
    "fsx:*",
    "glacier:*",
    "globalaccelerator:*",
    "glue:*",
    "greengrass:*",
    "guardduty:*",
    "importexport:*",
    "inspector:*",
    "iot:*",
    "kinesis:*",
    "kinesisanalytics:*",
    "kinesisvideo:*",
    "kms:*",
    "lambda:*",
    "logs:*",
    "macie:*",
    "mq:*",
    "neptune-db:*",
    "opsworks:*",
    "polly:*",
    "quicksight:*",
    "rekognition:*",
    "rds:*",
    "redshift:*",
    "robomaker:*",
    "route53:*",
    "sagemaker:*",
    "secretsmanager:*",
    "securityhub:*",
    "servicecatalog:*",
    "serverlessrepo:*",
    "sms:*",
    "shield:*",
    "sms:*",
    "sns:*",
    "sqs:*",
    "s3:*",
    "swf:*",
    "snowball:*",
    "states:*",
    "storagegateway:*",
    "ssm:*",
    "transcribe:*",
    "transfer:*",
    "translate:*",
    "waf:*",
    "workdocs:*",
    "worklink:*",
    "workspaces:*",
    "xray:*"
    ],
    "Resource": "*"
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "allow_hipaa_services_attachment" {
  policy_id = "${aws_organizations_policy.allow_hipaa_services.id}"
  target_id = "${var.target_id}"
}
