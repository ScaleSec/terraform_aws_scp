# terraform_aws_scp

This repo is a collection of AWS service control policies created in terraform to be used in AWS Organizations. 

## Getting Started

- The hipaa_scp folder is a service control policy written in terraform that whitelists HIPAA compliant AWS services based off https://aws.amazon.com/compliance/hipaa-eligible-services-reference/.
- The root_scp folder is a modularized grouping of AWS Best Practices to control at the AWS Organizations level.

### Prerequisites

Hashicorp Terraform and an Amazon Web Services Organization are required to use these service control policies.

### Notes

The file [hipaa_iam_notes](hipaa_scp/hipaa_iam_notes) contains information about IAM policies and HIPAA services and their potential mismatches. Not all IAM policies are granular enough to distinguish between sub-services.

### Disclaimer

The service control policies specified in this repo do not guarantee compliance and should be reviewed regularly for updates. ScaleSec is not liable for any regulatory compliance related to these policies.