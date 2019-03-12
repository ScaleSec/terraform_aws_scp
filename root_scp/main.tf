#-----root_scp/main.tf----#

provider "aws" {
  region = "${var.aws_region}"
}

## Deploy CloudTrail AWS Org Policies
module "cloudtrail" {
  source      = "./cloudtrail"
  org_root_id = "${var.org_root_id}"
}

## Deploy VPC AWS Org Policies
module "vpc" {
  source      = "./vpc"
  org_root_id = "${var.org_root_id}"
}

## Deploy AWS Config AWS Org Policies
module "awsconfig" {
  source      = "./awsconfig"
  org_root_id = "${var.org_root_id}"
}

## Deploy GuardDuty AWS Org Policies
module "guardduty" {
  source      = "./guardduty"
  org_root_id = "${var.org_root_id}"
}
