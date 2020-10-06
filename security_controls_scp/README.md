# Terraform AWS Orgs Guardrails

## Service Control Policies (SCPs)

The following SCPs should only be applied after the account has been configured properly. The pre-configuration includes all security tools and IAM permissions. The recommended best practice is to create an onboarding Organizational Unit (OU) that has limited permissions to deploy your tools and then move the account into an OU that has the security guardrails attached.

## Security Guardrails

### Account

- [deny_region_interaction.tf](./modules/account/deny_region_interaction.tf) - Denies the ability to enable or disable a region.
  - By default, when new regions are enabled by AWS, you now have to enable that region before IAM will propogate. 
  - This policy can be used to lock down the ability to launch resources in unapproved regions or deny a malicious actor from disabling a region in your account. 
  - *Important*: When a region is disabled, and there are IAM resources in that region, they will be removed. Please view the documentation [here](https://aws.amazon.com/blogs/security/setting-permissions-to-enable-accounts-for-upcoming-aws-regions/) for more information.

### AI Services

- [ai_services_opt_out.tf](./modules/ai/ai_services_opt_out.tf) - Opts out of sharing customer content processed by Amazon CodeGuru Profiler, Amazon Comprehend, Amazon Lex, Amazon Polly, Amazon Rekognition, Amazon Textract, Amazon Transcribe, and Amazon Translate for the development and continuous improvement of Amazon AI services and technologies.
  - This policy opts out of all services and does not allow child policies to opt in.
  - Please review the documentation [here](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_ai-opt-out_syntax.html) on how to selectively opt in to data sharing.
  - Prior to applying, ensure that the AI services opt-out policy type is enabled for the organization.

### AWS Config

- [deny_interruption_actions.tf](./modules/awsconfig/deny_interruption_actions.tf) - Denies the ability to delete AWS Config rules and stop recording. 
  - AWS Config is a service to monitor your resources for point-in-time configuration updates and compliance monitoring. 
  - Malicious actors may try to stop AWS Config recording and perform destructive behavior so it is important to deny AWS Config deletions.

### CloudTrail

- [deny_cloudtrail_actions.tf](./modules/cloudtrail/deny_cloudtrail_actions.tf) - Denies the ability to delete or manipulate CloudTrail trails. 
  - CloudTrail monitors all API calls against (supported) resources. 
  - Please note that not all AWS services and resources are supported by CloudTrail.
  - Because CloudTrail is a record of all API calls made, it is commonly targeted to cover malicious actors' tracks.

### EC2

- [require_mfa_actions.tf](./modules/ec2/require_mfa_actions.tf) - Requires MFA when deleting or stopping EC2 instances.
  - A best practice is to protect your resources from accidental deletions and requiring MFA is one step in that direction. 
- [restrict_ami_owner.tf](./modules/ec2/restrict_ami_owner.tf) - Locks down the AMIs that can be launched to only the AMI creation account.
  - A common practice is to configure an AWS account for centralized AMI creations that you then share to the receiving accounts. Similiar to a hub-and-spoke model.
- [require_ami_tag.tf](./modules/ec2/require_ami_tag.tf) - Requires a resource tag key/value pair to launch EC2s.
  - Requiring a specific resource tag key/value pair on an AMI in order to launch an EC2 instande is a form of ABAC (Attribute-Based Access Control). ABAC is a powerful access control configuration that AWS is supporting more and more with updates. For an in-depth breakdown of ABAC, visit this [tutorial](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html). Combining ABAC in the form of a resource tag and locking down AMIs to only specific owners/account IDs allows you to put different security checks in place for a layered approach.
- [deny_public_ami.tf](./modules/ec2/deny_public_ami.tf) - Denies the ability for users to deploy EC2 instances with public AMIs
  - A lot of organizations have their own internal AMIs with pre-baked security agents and other applications. If users have the ability to launch EC2s with public AMIs, they can circumvent the security tools. This SCP requires users to use private AMIs that are custom built (normally).
- [require_imdsv2.tf](./modules/ec2/require_imdsv2.tf) - Requires the use of IMDSv2 for all newly launched EC2 instances.
  - Be aware that if you use Auto Scaling groups you must use launch templates and NOT launch configurations. There are other requires noted [here.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ExamplePolicies_EC2.html#iam-example-instance-metadata)


### GuardDuty

- [deny_guardduty_disassociate.tf](./modules/guardduty/deny_guardduty_disassociate.tf) - Denies the ability to remove the assigned account from the GuardDuty master. 
  - Once GuardDuty is in place for an account, it should not be removed while in use. 

### IAM

- [deny_actions_no_mfa.tf](./modules/iam/deny_actions_no_mfa.tf) - Requires MFA to be set before any action can be performed. 
  - The user will only be able to set a MFA device and then must log out / in to have normal access.
  - This is a blanket guardrail that should be used caustiously. Keep in mine that unless the user authenticated with MFA via the CLI, access keys will not be valid. 

### Lambda

- [require_vpc_lambda.tf](./modules/lambda/require_vpc_lambda.tf) - Requires lambda functions to be deployed in a customer-managed VPC.
  - Use this SCP with caution as you need to have enough IPs available in your subnets. In addition, if the lambda needs to reach out to the internet, you also need to configure outbound access in your VPC.

### AWS Organizations

- [deny_orgs_leave.tf](./modules/organizations/deny_orgs_leave.tf) - Denies the ability to remove an account from the AWS Organization it is assigned to.

### RDS

- [deny_unencrypted_actions.tf](./modules/rds/deny_unencrypted_actions.tf) - Deny RDS actions that do not specify encryption flags
  - This SCP covers all RDS actions that support encryption and denies if the user does not specify encryption for the resource.

### S3

- Recommended best practice is to encrypt everything in s3. These rules require encryption at rest and in transit.
    - [deny_unencrypted_uploads.tf](./modules/s3/deny_unencrypted_uploads.tf) - Requires all S3 Uploads to use Encryption at Rest.
    - [deny_unsecure_requests.tf](./modules/s3/deny_unsecure_requests.tf) - Denies non-TLS S3 Requests
- [require_mfs_delete.tf](./modules/s3/require_mfs_delete.tf) - Requires MFA When Deleting Objects
- [deny_public_access_points.tf](./modules/s3/deny_public_access_points.tf) - Denies the creation of publicly facing [Access Points](https://aws.amazon.com/s3/features/access-points/).
- [s3_region_lockdown.tf](./modules/s3/s3_region_lockdown.tf) - Restricts the region(s) where S3 buckets can be created. Update the variables file [here](https://github.com/ScaleSec/terraform_aws_scp/blob/master/security_controls_scp/variables.tf).

### AWS Shield

- [deny_shield_removal.tf](./modules/shield/deny_shield_removal.tf) - Denies the ability to remove AWS Shield protection or update the emergency contact information.
  - AWS Shield is a DDoS protection service which should be turned on 24/7.

### VPC

- [deny_flow_logs_delete.tf](./modules/vpc/deny_flow_logs_delete.tf) - Denies the ability to delete VPC Flow Logs.
  - VPC Flow Logs are your network monitoring logs and provide visibility into anomalous traffic during a security event. 


