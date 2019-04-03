provider "aws" {}

## Deploy CloudTrail AWS Org Policies
module "cloudtrail" {
  source = "modules/cloudtrail"

  target_id = "${var.target_id}"
}

## Deploy VPC AWS Org Policies
module "vpc" {
  source = "modules/vpc"

  target_id = "${var.target_id}"
}

## Deploy AWS Config AWS Org Policies
module "awsconfig" {
  source = "modules/awsconfig"

  target_id = "${var.target_id}"
}

## Deploy GuardDuty AWS Org Policies
module "guardduty" {
  source = "modules/guardduty"

  target_id = "${var.target_id}"
}

## Deploy S3 AWS Org Policies
module "s3" {
  source = "modules/s3"

  target_id = "${var.target_id}"
}

## Deploy EC2 AWS Org Policies
module "ec2" {
  source = "modules/ec2"

  target_id = "${var.target_id}"
}

## Deploy AWS Organizations SCPs
module "organizations" {
  source = "modules/organizations"

  target_id = "${var.target_id}"
}

## Deploy IAM Aws Org SCPs
module "iam" {
  source = "modules/iam"

  target_id = "${var.target_id}"
}

## Deploy Shield AWS Org Policies
module "shield" {
  source = "modules/shield"

  target_id = "${var.target_id}"
}
