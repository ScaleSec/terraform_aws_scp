# hipaa_iam_notes

- Below are notes based off research between IAM permissions and the HIPAA service list located here: https://aws.amazon.com/compliance/hipaa-eligible-services-reference/
- Be aware that some services are not granular enough in IAM to distinguish between compliance flavors. IE: ElastiCache redis v memcached.

### HIPAA BAA to IAM Mapping

There are HIPAA BAA compliant services or programs that do not map directly to IAM permissions or the API/SDK one to one. In addition, some of the IAM permissions are not yet supported in the console but do have an API authorized via IAM permissions. The below table attempts to consolidate the inconsistencies.

| Service/Program | API/CLI/SDK | Supported in Console |
|-----------------|---------|----------------------|
| Amazon Aurora (MySQL,PostgreSQL) | `rds` | True |
| Amazon CloudWatch SDK Metrics | `cloudwatch` | True |
| Amazon DocumentDB (with MongoDB compatibility) | `rds` | True |
| Amazon Elastic Block Store (EBS) | `ec2` | True |
| Amazon Forecast | `forecast` | __False__ |
| Amazon Virtual Private Cloud (VPC) | `ec2` | True |
| AWS Managed Services | __N/A__ | __N/A__ |
| AWS Snowball Edge | `snowball` | True |
| AWS Snowmobile | `snowball` | True |
| AWS VM Import/Export** | __N/A__ | __N/A__ |

** VM Import/Export does not have a specific API/SDK but instead uses a combination of `ec2` and `s3`.

### Known Incompatabilities

- __Amazon SageMaker [excluding Public Workforce and Vendor Workforce].__ Sagemaker does not handle permissions on a workforce level. `sagemaker:*` was added to the allowed list in the SCP.
- __Amazon ElastiCache (Redis).__ IAM Permissions for elasticache does not differentiate between memcached and redis. `elasticache:*` was added to the allowed list in the SCP which allows non-compliant memcached instances.
- __AWS Directory Services excluding Simple AD and AD Connector.__ IAM permissions do not differentiate between AD Connector and Simple AD. `ds:*` was added to the allowed list in the SCP which allows non-compliant Simple AD and AD Connector. 