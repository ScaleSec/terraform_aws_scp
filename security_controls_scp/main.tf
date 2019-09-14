provider "aws" {
}

## Deploy Account AWS Org SCPs
module "account" {
  source = "./modules/account"

  target_id = var.target_id
}

## Deploy AWS Config AWS Org SCPs
module "awsconfig" {
  source = "./modules/awsconfig"

  target_id = var.target_id
}

## Deploy CloudTrail AWS Org SCPs
module "cloudtrail" {
  source = "./modules/cloudtrail"

  target_id = var.target_id
}

## Deploy EC2 AWS Org SCPs
module "ec2" {
  source = "./modules/ec2"

  target_id = var.target_id
}

## Deploy GuardDuty AWS Org SCPs
module "guardduty" {
  source = "./modules/guardduty"

  target_id = var.target_id
}

## Deploy IAM Aws Org SCPs
module "iam" {
  source = "./modules/iam"

  target_id = var.target_id
}

## Deploy AWS Organizations SCPs
module "organizations" {
  source = "./modules/organizations"

  target_id = var.target_id
}

## Deploy S3 AWS Org SCPs
module "s3" {
  source = "./modules/s3"

  target_id = var.target_id
}

## Deploy Shield AWS Org SCPs
module "shield" {
  source = "./modules/shield"

  target_id = var.target_id
}

## Deploy VPC AWS Org SCPs
module "vpc" {
  source = "./modules/vpc"

  target_id = var.target_id
}

