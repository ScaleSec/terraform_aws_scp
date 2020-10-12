# Terraform AWS Service Control Policies

This repo is a collection of AWS Service Control Policies (SCPs) written in Hashicorp Terraform to be used in AWS Organizations.

## About Service Control Policies

- For official documentation about SCPs, visit the links [here](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html) and [here.](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_about-scps.html)
- SCPs enable you to restrict, at the account level of granularity, what services and actions the users, groups and roles in those accounts can do.
- SCPs are available only in an organization that has all features enabled. SCPs aren't available if your organization has enabled only the consolidated billing features.

## Considerations

- Best practice is to never attach SCPs to the root of your organization. Instead, create an Organizational Unit (OU) underneath root and attach policies there.
- SCPs do not grant permissions in IAM but instead allow/deny services or set security guardrails.
- Root user accounts are affected by SCPs.
- You must have at least one SCP attached to each entity.
- Maximum of 5 SCPs can be attached to the root, OU, or Account in an organization.

### Permission Logic

- If a user or role has an IAM permission policy that grants access to an action that is also allowed by the applicable SCPs, the user or role can perform that action.
- If a user or role has an IAM permission policy that grants access to an action that is either not allowed or explicitly denied by the applicable SCPs, the user or role can't perform that action.
- AWS Organizations use a tree hierarchy for SCPs. This means that if your account is in an Organizational Unit, it inherits that OUs policies.
- From the documentation:

![alt text](https://docs.aws.amazon.com/organizations/latest/userguide/images/How_SCP_Permissions_Work.png "SCP Venn Diagram")

## Content

- The [security_controls_scp](security_controls_scp/) folder is a modularized grouping of AWS Security Best Practices to control at the AWS Organizations level.
  - __NOTICE:__ Due to the limitations of Service Control Policies, only a max of 5 may be attached at one time. With that in mind, you cannot apply ALL of the security controls at once (in their current modularized format). All of the SCPs will attempt to attach to one target ID and will fail. You have a couple of options:
    - Select the `aws_iam_policy_document` you want and combine into one large data document.
    - Pick and choose 5 modules to deploy and remove the others.
    - Remove `aws_organizations_policy_attachment` from the modules' `main.tf` file and apply. You would then need to manually attach the SCPs.
- The [hipaa_scp](hipaa_scp/) folder is a service control policy that whitelists HIPAA compliant AWS services based off of https://aws.amazon.com/compliance/hipaa-eligible-services-reference/.
- The [pci_scp](pci_scp/) folder is a service control policy that whitelists PCI compliant AWS services based off of https://aws.amazon.com/compliance/services-in-scope/.

## Usage

An example main.tf for the module to deny the ability to delete CloudTrail Trails:

```hcl
module "cloudtrail" {
  source      = "./modules/cloudtrail"

  target_id = "123456789012"
  aws_region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  customprofile = "default"
}
```
### Deployment

To Deploy all of the AWS security best practice SCPs (navigate to [__security_controls_scp__])(./security_controls_scp):
- `terraform init` to get the plugins.
- `terraform plan` to verify your resource planning.
- `terraform apply` to apply your SCPs.

You will receive an error related similar to `ConstraintViolationException: You have attached the maximum number of policies to the specified target.` when you deploy ALL of the security related SCPs. We recommend only deploying the SCPs you need by leveraging the `-target` flag in your `terraform apply` command. An example command to deploy only the S3 and Lambda SCPs is below:
- `terraform apply -target=module.s3 -target=module.lambda`

To Remove the SCPs:
- `terraform destroy` to destroy the deployed policies.

### Deployment Dependencies

- [Terraform v12](https://www.terraform.io/downloads.html)
- [terraform-provider-aws](https://github.com/terraform-providers/terraform-provider-aws)
- An AWS Organization
- An IAM user with Organization Admin Access

## Common Errors 

#### Enabled Policy Types

```
error creating Organizations Policy Attachment: PolicyTypeNotEnabledException: This operation can be performed only for enabled policy types.  
status code: 400, request id: 2b8ecgeb-34h3-11e6-86fb-275c76986dec
```

SCP functionality must be enabled on the root.  See https://github.com/terraform-providers/terraform-provider-aws/issues/4545 for more information 

#### Minimum SCP Requirement

```
aws_organizations_policy_attachment.deny_orgs_leave_attachment: ConstraintViolationException: You cannot remove the last policy attached to the specified target. You must have at least one attached at all times.
status code: 400, request id: 2d6c75b3-5757-13e9-ab76-518b756aebd3
```

You must have one SCP attached to an account or OU at all times. See: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_limits.html for more information.

#### Conflicting Policy Attachment

```
error creating Organizations Policy Attachment: ConcurrentModificationException: AWS Organizations can't complete your request because it conflicts with another attempt to modify the same entity. Try again later. status code: 400, request id: h725f9g7-1234-12e9-h746-ch123ab12345
```

Occasionally, if you try to assign many SCPs to one target at the same time, it could error out. If you see this error simply run `terraform apply` again.

## Limitation of Liability

Please view the [License](LICENSE) for limitations of liability. 

