#-----security_controls_scp/main.tf----#

provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile = "${var.customprofile}"
}

## Deploy CloudTrail AWS Org Policies
module "cloudtrail" {
  source      = "modules/cloudtrail"

  target_id = "${var.target_id}"
}

## Deploy VPC AWS Org Policies
module "vpc" {
  source      = "modules/vpc"

  target_id = "${var.target_id}"
}

## Deploy AWS Config AWS Org Policies
module "awsconfig" {
  source      = "modules/awsconfig"

  target_id = "${var.target_id}"
}

## Deploy GuardDuty AWS Org Policies
module "guardduty" {
  source      = "modules/guardduty"
  
  target_id = "${var.target_id}"
}
