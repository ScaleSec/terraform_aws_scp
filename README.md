# Terraform AWS Service Control Policies

This repo is a collection of AWS Service Control Policies (SCPs) written in Hashicorp Terraform to be used in AWS Organizations.

## About Service Control Policies

- For official documentation about SCPs, visit the links [here](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html) and [here.](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_about-scps.html)
- SCPs enable you to restrict, at the account level of granularity, what services and actions the users, groups and roles in those accounts can do.
- SCPs are available only in an organization that has all features enabled. SCPs aren't available if your organization has enabled only the consolidated billing features.

## Considerations

- Best practice is to never attach SCPs to the root of your organization. Instead, create an Organizational Unit (OU) underneath root and attach policies there.
- SCPs do not grant permissions in IAM but instead whitelist/blacklist services or set security guardrails.
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

- The [security_controls_scp](security_controls_scp/) folder is a modularized grouping of AWS Security Best Practices to control at the AWS Organizations level.
  - __NOTICE:__ Due to the limitations of Service Control Policies, only a max of 5 may be attached at one time. With that in mind, you cannot apply ALL of the security controls at once (in their current modularized format). All of the SCPs will attempt to attach to one target ID and will fail. You have a couple of options:
    - Select and move the JSON policies you want into one large `aws_organizations_policy` and apply.
    - Pick and choose 5 modules to deploy and remove the others.
    - Remove `aws_organizations_policy_attachment` from the modules' `main.tf` file and apply. You would then need to manually apply the SCPs.
- __[Future Functionality]__ The [hipaa_scp](hipaa_scp/) folder is a service control policy that whitelists HIPAA compliant AWS services based off of https://aws.amazon.com/compliance/hipaa-eligible-services-reference/.
- __[Future Functionality]__ The [pci_scp](pci_scp/) folder is a service control policy that whitelists PCI compliant AWS services based off of https://aws.amazon.com/compliance/services-in-scope/

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

Please view the [License](LICENSE) for limitations of liability. 

