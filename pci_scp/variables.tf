#-----pci_scp/variables.tf-----#

variable "aws_region" {
  description = "The AWS Region of your PCI account(s)"
}

variable "pci_account_id" {
  description = "The PCI compliant AWS account ID."
}
