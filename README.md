# Terraform AWS Service Control Policies

This repo is a collection of AWS Service Control Policies (SCPs) written in Hashicorp Terraform to be used in AWS Organizations.

## About Service Control Policies

- For complete documentation about SCPs, visit the official documentation [here](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html) and [here.](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_about-scps.html)
- SCPs enable you to restrict, at the account level of granularity, what services and actions the users, groups, and roles in those accounts can do.
- SCPs are available only in an organization that has all features enabled. SCPs aren't available if your organization has enabled only the consolidated billing features.

## Considerations

- Best practice is to never attach SCPs to the root of your organization. Instead, create an Organizational Unit (OU) underneath root and attach policies there.
- SCPs do not grant individual permissions but instead whitelist or blacklist services that are allowed to be accessed or blocked. 
- Root user accounts are affected by SCPs.
- You must have at least one SCP attached to each entity.
- Maximum of 5 SCPs can be attached to the root, OU, or Account in an organization.

### Permission Logic

- If a user or role has an IAM permission policy that grants access to an action that is also allowed by the applicable SCPs, the user or role can perform that action.
- If a user or role has an IAM permission policy that grants access to an action that is either not allowed or explicitly denied by the applicable SCPs, the user or role can't perform that action.
- AWS Organizations use a tree hierarchy for SCPs. This means that if your account is in an Organizational Unit, it inherits that OUs policies.
- From the documentation:

![alt text](https://docs.aws.amazon.com/organizations/latest/userguide/images/How_SCP_Permissions_Work.jpg "SCP Venn Diagram")

## Content

- The [hipaa_scp](hipaa_scp/) folder is a service control policy that whitelists HIPAA compliant AWS services based off of https://aws.amazon.com/compliance/hipaa-eligible-services-reference/.
- The [security_controls_scp](security_controls_scp/) folder is a modularized grouping of AWS Security Best Practices to control at the AWS Organizations level.
- The [pci_scp](pci_scp/) folder is a service control policy that whitelists PCI compliant AWS services based off of https://aws.amazon.com/compliance/services-in-scope/

## Usage

An example main.tf for the module to deny the ability to delete CloudTrail Trails:

```hcl
module "cloudtrail" {
  source      = "modules/cloudtrail"

  target_id = "123456789012"
  aws_region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  customprofile = "default"
}
```

To Deploy all of the AWS best practice SCPs (navigate to the root __security_controls_scp__):
- `terraform init` to get the plugins.
- `terraform plan` to verify your resource planning.
- `terraform apply` to apply your SCPs.

To Remove the SCPs:
- `terraform destroy` to destroy the deployed policies.

## Inputs / Variables ###

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_region | The AWS Region where your AWS Organization is configured. | string | `"us-east-1"` | yes |
| target\_id | The Root ID, Organizational Unit ID, or AWS Account ID to apply SCPs. | string | `"N/A"` | yes |
| shared\_credentials\_file | The local AWS credentials file. | string | `"N/A"` | yes |
| customprofile | The profile to use inside the __shared_credentials_file__. | string | `"N/A"` | yes |

## Deployment Dependencies

- [Terraform](https://www.terraform.io/downloads.html)
- [terraform-provider-aws](https://github.com/terraform-providers/terraform-provider-aws)
- An AWS Organization
- An IAM user with Organization Admin Access

## Limitation of Liability

The service control policies specified in this repo do not guarantee compliance and should be reviewed regularly for updates. ScaleSec is not liable for any regulatory compliance related to these policies. Use at your own risk.
