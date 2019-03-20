#-----security_controls_scp/variables.tf----#

variable "aws_region" {
  description = "The AWS region where your master organization account lives."
}

variable "target_id" {
  description = "The Target ID to attach the policies to. Can be root, organizational unit, or individual account."
  }

variable "shared_credentials_file" {
  description = "The location of aws credentials file. Example: ~/.aws/credentials"
}

variable "customprofile" {
  description = "The profile to be used from the credentials file."
}