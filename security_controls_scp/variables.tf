#-----security_controls_scp/variables.tf----#

variable "aws_region" {
  description = "The AWS Region of your HIPAA account(s)"
  default = "us-east-1"
}

variable "target_id" {
  description = "The HIPAA compliant AWS account ID."
}

variable "shared_credentials_file" {
  description = "The location of aws credentials file. Example: ~/.aws/credentials"
}

variable "customprofile" {
  description = "The profile to be used from the credentials file."
}