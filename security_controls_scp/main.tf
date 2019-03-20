#-----security_controls_scp/main.tf----#

provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "${var.shared_credentials_file}"
  profile = "${var.customprofile}"
}

## Deploy CloudTrail AWS Org Policies
module "cloudtrail" {
  source      = "./cloudtrail"
  target_id = "${var.target_id}"
}

## Deploy VPC AWS Org Policies
module "vpc" {
  source      = "./vpc"
  target_id = "${var.target_id}"
}

## Deploy AWS Config AWS Org Policies
module "awsconfig" {
  source      = "./awsconfig"
  target_id = "${var.target_id}"
}

## Deploy GuardDuty AWS Org Policies
module "guardduty" {
  source      = "./guardduty"
  target_id = "${var.target_id}"
}
