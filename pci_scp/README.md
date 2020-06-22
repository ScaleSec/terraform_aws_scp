# pci_iam_notes

- Below are notes based off research between IAM permissions and the PCI service list located here: https://aws.amazon.com/compliance/services-in-scope/.
- Be aware that some services are not granular enough in IAM to distinguish between compliance flavors. IE: ElastiCache redis v memcached.

### PCI-DSS to IAM Mapping

There are PCI-DSS compliant services or programs that do not map directly to IAM permissions or the API/SDK one to one. In addition, some of the IAM permissions are not yet supported in the console but do have an API authorized via IAM permissions. The below table attempts to consolidate the inconsistencies.

| Service/Program | IAM Permission | Supported in Console |
|-----------------|---------|----------------------|
| Amazon DocumentDB (with MongoDB compatibility) | `rds` | True |
| Amazon Elastic Block Store (EBS) | `ec2` | True |
| Amazon S3 Transfer Acceleration | `s3transferacceleration` | False |
| Amazon Virtual Private Cloud (VPC) | `ec2` | True |
| AWS Managed Services | __N/A__ | __N/A__ |
| AWS Snowball Edge | `snowball` | True |
| AWS Snowmobile | `snowball` | True |
| AWS VM Import/Export* | __N/A__ | __N/A__ |
| AWS Control Tower** | __N/A__ | __N/A__ |

* VM Import/Export does not have a specific API/SDK but instead uses a combination of `ec2` and `s3`.
** AWS Control Tower does not have a specific IAM permission but instead uses a combination of `ec2`, `logs` and many others

### Known Incompatabilities

- __Amazon SageMaker [excluding Public Workforce and Vendor Workforce].__ Sagemaker does not drill down into different workforces in IAM.
- __AWS Directory Services excluding Simple AD and AD Connector.__ IAM permissions do not differentiate between AD Connector and Simple AD so "ds:*" was excluded.