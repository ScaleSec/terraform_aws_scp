#-----security_controls_scp/variables.tf----#

variable "aws_region" {
  description = "The AWS region where your master organization account lives."
}

variable "target_id" {
  description = "The Target ID to attach the policies to. Can be root, organizational unit, or individual account."
  }