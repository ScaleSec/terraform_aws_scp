#-----hipaa_scp/variables.tf-----#

variable "aws_region" {
  description = "The AWS Region of your HIPAA account(s)"
}

variable "hipaa_account_id" {
  description = "The HIPAA compliant AWS account ID."
}
