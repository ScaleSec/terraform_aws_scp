# terraform_aws_scp

This repo is a collection of AWS service control policies created in terraform to be used in AWS Organizations. 

## Getting Started

The hipaa_scp folder is a service control policy written in terraform that whitelists HIPAA compliant AWS services based off https://aws.amazon.com/compliance/hipaa-eligible-services-reference/.

The root_scp folder is a modularized grouping of AWS Best Practices to control at the AWS Organizations level.

### Prerequisites

Hashicorp terraform and an Amazon Web Services Organization are required to use these service control policies.

### Deployment Steps