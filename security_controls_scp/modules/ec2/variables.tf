#-----security_controls_scp/modules/ec2/variables.tf----#
variable "target_id" {
  description = "The Root ID, Organizational Unit ID, or AWS Account ID to apply SCPs."
  type        = string
}

variable "AmiCreatorAccount" {
  description = "The AWS account ID that is responsible for creating and sharing EC2 AMIs."
  type        = string
}
