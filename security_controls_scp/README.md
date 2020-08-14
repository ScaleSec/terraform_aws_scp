# Terraform AWS Orgs Guardrails

## Service Control Policies (SCPs)

The following SCPs should only be applied after the account has been configured properly. The pre-configuration includes all security tools and IAM permissions. The recommended best practice is to create an on-boarding Organizational Unit that has limited permissions to deploy your tools and then move the account into an OU that has the security guardrails attached.

## Security Guardrails

### Account

- Denies the ability to enable or disable a region.
  - By default, when new regions are enabled by AWS, you now have to enable that region before IAM will propogate. 
  - This policy can be used to lock down the ability to launch resources in unapproved regions or deny a malicious actor from disabling a region in your account. 
  - *Important*: When a region is disabled, and there are IAM resources in that region, they will be removed. Please view the documentation [here](https://aws.amazon.com/blogs/security/setting-permissions-to-enable-accounts-for-upcoming-aws-regions/) for more information.

### AI Services

- Opts out of sharing customer content processed by Amazon CodeGuru Profiler, Amazon Comprehend, Amazon Lex, Amazon Polly, Amazon Rekognition, Amazon Textract, Amazon Transcribe, and Amazon Translate for the development and continuous improvement of Amazon AI services and technologies.
  - This policy opts out of all services and does not allow child policies to opt in.
  - Please review the documentation [here](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_ai-opt-out_syntax.html) on how to selectively opt in to data sharing.
  - Prior to applying, ensure that the AI services opt-out policy type is enabled for the organization.

### AWS Config

- Denies the ability to delete AWS Config rules and stop recording. 
  - AWS Config is a service to monitor your resources for point-in-time configuration updates and compliance monitoring. 
  - Malicious actors may try to stop AWS Config recording and perform destructive behavior so it is important to deny AWS Config deletions.

### CloudTrail

- Denies the ability to delete CloudTrail trails. 
  - CloudTrail monitors all API calls against (supported) resources. 
  - Please note that not all AWS services and resources are supported by CloudTrail.
  - Because CloudTrail is a record of all API calls made, it is commonly targeted to cover malicious actors' tracks.

### EC2

- Requires MFA when deleting or stopping EC2 instances.
  - A best practice is to protect your resources from accidental deletions and requiring MFA is one step in that direction. 
- Locks down the AMIs that can be launched to only the AMI creation account.
  - A common practice is to configure an AWS account for centralized AMI creations that you then share to the receiving accounts. Similiar to a hub-and-spoke model.
- Requires a resource tag key/value pair to launch EC2s.
  - Requiring a specific resource tag key/value pair on an AMI in order to launch an EC2 instande is a form of ABAC (Attribute-Based Access Control). ABAC is a powerful access control configuration that AWS is supporting more and more with updates. For an in-depth breakdown of ABAC, visit this [tutorial](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html). Combining ABAC in the form of a resource tag and locking down AMIs to only specific owners/account IDs allows you to put different security checks in place for a layered approach.


### GuardDuty

- Denies the ability to remove the assigned account from the GuardDuty master. 
  - Once GuardDuty is in place for an account, it should not be removed while in use. 

### IAM

- Requires MFA to be set before any action can be performed. 
  - The user will only be able to set a MFA device and then must log out / in to have normal access.
  - This is a blanket guardrail that should be used caustiously. Keep in mine that unless the user authenticated with MFA via the CLI, access keys will not be valid. 

### AWS Organizations

- Denies the ability to remove an account from the AWS Organization it is assigned to.

### S3

- Recommended best practice is to encrypt everything in s3. These rules require encryption at rest and in transit.
    - Requires all S3 Uploads to use Encryption at Rest.
    - Denies non-TLS S3 Requests
- Requires MFA When Deleting Objects
- Denies the creation of publicly facing [Access Points](https://aws.amazon.com/s3/features/access-points/).
- Restricts the region(s) where S3 buckets can be created. Update the variables file [here](https://github.com/ScaleSec/terraform_aws_scp/blob/master/security_controls_scp/variables.tf).

### AWS Shield

- Denies the ability to remove AWS Shield protection or update the emergency contact information.
  - AWS Shield is a DDoS protection service which should be turned on 24/7.

### VPC

- Denies the ability to delete VPC Flow Logs.
  - VPC Flow Logs are your network monitoring logs and provide visibility into anomalous traffic during a security event. 
