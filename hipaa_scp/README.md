# HIPAA Services and AWS IAM 

- Below are notes based off research between IAM permissions and the HIPAA service list located here: https://aws.amazon.com/compliance/hipaa-eligible-services-reference/
- Be aware that some services are not granular enough in IAM to distinguish between compliance flavors. IE: ElastiCache redis v memcached.

### HIPAA BAA to IAM Mapping

There are HIPAA BAA compliant services or programs that do not map directly to IAM permissions or the API/SDK one to one. In addition, some of the IAM permissions are not yet supported in the console but do have an API authorized via IAM permissions. The below table attempts to consolidate the inconsistencies.

| Service/Program | IAM Permission | Supported in Console | Included in SCP 
|-----------------|---------|----------------------|-------------|
| Amazon Augmented AI (Amazon A2I) | `sagemaker` | True | True |
| Amazon Aurora (MySQL,PostgreSQL) | `rds` | True | True |
| Amazon CloudWatch SDK Metrics | `cloudwatch` | True | True |
| Amazon DocumentDB (with MongoDB compatibility) | `rds` | True | True |
| Amazon HealthLake (preview) | `healthlake` | False | True
| Amazon Virtual Private Cloud (VPC) | `ec2` | True | True |
| AWS CloudEndure** |__N/A__ | __N/A__ | __N/A__ |
| AWS Control Tower* | __N/A__ | __N/A__ | __N/A__ |
| AWS Database Migration Service* | __N/A__ | __N/A__ | __N/A__ |
| AWS IoT Device Management | `iot` | True | True
| AWS Managed Services | __N/A__ | __N/A__ | __N/A__ |
| AWS Snowball Edge | `snowball` | True | True |
| AWS Snowmobile | `snowball` | True | True |
| AWS VM Import/Export* | __N/A__ | __N/A__ | __N/A__ |
| Elastic Load Balancing | `ec2` | True | True

- `*` These services do not have a specific IAM permission but instead uses a combination for the service.
- `**` __AWS CloudEndure__ does not have a specific IAM permission and has it's own [console](https://console.cloudendure.com/) 

### Known Incompatabilities

- __Amazon SageMaker [excluding Public Workforce and Vendor Workforce].__ Sagemaker does not handle permissions on a workforce level. `sagemaker:*` was added to the allowlist in the SCP.
- __Amazon ElastiCache (Redis).__ IAM Permissions for elasticache does not differentiate between memcached and redis. `elasticache:*` was added to the allowlist in the SCP which allows non-compliant memcached instances.
- __AWS Directory Services excluding Simple AD and AD Connector.__ IAM permissions do not differentiate between AD Connector and Simple AD. `ds:*` was added to the allowlist in the SCP which allows non-compliant Simple AD and AD Connector. 