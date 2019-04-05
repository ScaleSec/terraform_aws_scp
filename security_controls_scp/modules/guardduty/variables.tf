#-----security_controls_scp/modules/guardduty/variables.tf----#
variable "target_id" {
  description = "The Root ID, Organizational Unit ID, or AWS Account ID to apply SCPs."
  type        = "string"
}
