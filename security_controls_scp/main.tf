provider "aws" {
  region  = "us-east-1"
}

## Deploy Account AWS Org SCPs
module "account" {
  source = "./modules/account"

  target_id = var.target_id
}

## Deploy AI Services Data Opt-out Org SCPs
module "ai" {
  source = "./modules/ai"

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

  target_id         = var.target_id
  ami_creator_account = var.ami_creator_account
  ami_tag_key       = var.ami_tag_key
  ami_tag_value     = var.ami_tag_value
  imdsv2_max_hop    = var.imdsv2_max_hop
}

## Deploy EFS AWS Org SCPs
module "efs" {
  source = "./modules/efs"

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

## Deploy Lambda AWS Org SCPs
module "lambda" {
  source = "./modules/lambda"

  target_id = var.target_id
}

## Deploy AWS Organizations SCPs
module "organizations" {
  source = "./modules/organizations"

  target_id = var.target_id
}

## Deploy RDS AWS Org SCPs
module "rds" {
  source = "./modules/rds"

  target_id = var.target_id
}

## Deploy S3 AWS Org SCPs
module "s3" {
  source = "./modules/s3"

  target_id       = var.target_id
  region_lockdown = var.region_lockdown
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
