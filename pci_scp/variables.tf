#-----pci_scp/variables.tf-----#

variable "aws_region" {
  description = "The AWS Region of your PCI account(s)"
  default = "us-east-1"
}

variable "pci_account_id" {
  description = "The PCI compliant AWS account ID."
}

variable "shared_credentials_file" {
  description = "The location of aws credentials file. Example: ~/.aws/credentials"
}

variable "customprofile" {
  description = "The profile to be used from the credentials file."
}