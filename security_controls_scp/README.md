# Terraform AWS Orgs Guardrails

## Service Control Policies (SCPs)

The following SCPs should only be applied once the account has been configured properly. This includes all security tools and IAM permissions. The recommended practice is to create an on-boarding Organizational Unit that has limited permissions to deploy your tools and then move the account into an OU that has the security guardrails attached.

## Security Guardrails Deployed

### AWS Config

- Denies the ability to delete Config rules and stop recording. 
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

- Requires all S3 Uploads to use Encryption at Rest.
- Denies non-TLS S3 Requests
- Requires MFA When Deleting Objects
- Recommended best practice is to encrypt everything in s3. These rules require encryption at rest and in transit.

### AWS Shield

- Denies the ability to remove AWS Shield protection or update the emergency contact information.
- AWS Shield is a DDoS protection service which should be turned on 24/7.

### VPC

- Denies the ability to delete VPC Flow Logs.
- VPC Flow Logs are your network monitoring logs and provide visibility into anomalous traffic during a security event. 