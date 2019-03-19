# Terraform AWS Service Control Policies

This repo is a collection of AWS service control policies written in Hashicorp Terraform to be used in AWS Organizations. Service Control Policies trump all IAM permissions making these extremely powerful.

### Content

- The [hipaa_scp](hipaa_scp/) folder is a service control policy that whitelists HIPAA compliant AWS services based off of https://aws.amazon.com/compliance/hipaa-eligible-services-reference/.
- The [root_scp](root_scp/) folder is a modularized grouping of AWS Best Practices to control at the AWS Organizations level.
- The [pci_scp](pci_scp/) folder is a service control policy that whitelists PCI compliant AWS services based off of https://aws.amazon.com/compliance/services-in-scope/

### Prerequisites

Hashicorp Terraform and an Amazon Web Services Organization are required to use the service control policies.

### Notes

The files [hipaa_iam_notes](hipaa_scp/hipaa_iam_notes) and [pci_iam_notes](pci_scp/pci_iam_notes) contain information about IAM policies and HIPAA/PCI services regarding their potential mismatches. Not all IAM policies are granular enough to distinguish between sub-services.

### Disclaimer

The service control policies specified in this repo do not guarantee compliance and should be reviewed regularly for updates. ScaleSec is not liable for any regulatory compliance related to these policies.
