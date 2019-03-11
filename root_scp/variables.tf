#-----root_scp/variables.tf----#

variable "aws_region" {
  description = "The AWS region where your master organization account lives."
}

variable "org_root_id" {
  description = "The AWS Root Organization Id. Must be in the format 'r-{id}"
}
