#-----pci_scp/variables.tf-----#

variable "aws_region" {
  description = "The AWS Region of your AWS Organization."
  default = "us-east-1"
}

variable "target_id" {
  description = "The Root ID, Organizational Unit ID, or AWS Account ID to apply SCPs."
}

variable "shared_credentials_file" {
  description = "The location of aws credentials file. Example: ~/.aws/credentials"
}

variable "customprofile" {
  description = "The profile to be used from the credentials file."
}