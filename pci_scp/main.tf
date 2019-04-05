# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/
resource "aws_organizations_policy" "allow_pci_services" {
  name        = "Allow PCI Services"
  description = "Only allow PCI services"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Effect": "Allow",
    "Action": [
    "apigateway:*",
    "appsync:*",
    "athena:*",
    "autoscaling:*",
    "backup:*",
    "batch:*",
    "acm:*",
    "clouddirectory:*",
    "cloudformation:*",
    "cloudfront:*",
    "cloudhsm:*",
    "cloudtrail:*",
    "codebuild:*",
    "codecommit:*",
    "cognito-identity:*",
    "cognito-idp:*",
    "cognito-sync:*",
    "comprehend:*",
    "config:*",
    "connect:*",
    "datasync:*",
    "directconnect:*",
    "dms:*",
    "ds:*",
    "dynamodb:*",
    "ec2:*",
    "ecr:*",
    "ecs:*",
    "elasticbeanstalk:*",
    "elasticache:*",
    "elasticfilesystem:*",
    "eks:*",
    "elasticloadbalancing:*",
    "elasticmapreduce:*",
    "es:*",
    "firehose:*",
    "fms:*",
    "freertos:*",
    "fsx:*",
    "glacier:*",
    "globalaccelerator:*",
    "glue:*",
    "greengrass:*",
    "guardduty:*",
    "iam:*",
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
    "opsworks-cm:*",
    "polly:*",
    "quicksight:*",
    "rekognition:*",
    "rds:*",
    "redshift:*",
    "robomaker:*",
    "route53:*",
    "sagemaker:*",
    "sdb:*",
    "secretsmanager:*",
    "servicecatalog:*",
    "serverlessrepo:*",
    "sms:*",
    "shield:*",
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
    "workspaces:*",
    "xray:*"
    ],
    "Resource": "*"
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "allow_pci_services_attachment" {
  policy_id = "${aws_organizations_policy.allow_pci_services.id}"
  target_id = "${var.target_id}"
}
