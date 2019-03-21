# pci_iam_notes

- Below are notes based off research between IAM permissions and the PCI service list located here: https://aws.amazon.com/compliance/services-in-scope/.
- Be aware that some services are not granular enough in IAM to distinguish between compliance flavors. IE: ElastiCache redis v memcached.

### These services are not in IAM 

- AWS Elemental MediaConnect
- AWS Elemental MediaConvert
- AWS Elemental MediaLive
- AWS Managed Services

### Known Incompatabilities

- __Amazon SageMaker [excluding Public Workforce and Vendor Workforce].__ Sagemaker does not drill down into different workforces in IAM
- __Amazon ElastiCache (Redis).__ IAM Permissions for elasticache does not differentiate between memcached and redis.
- __AWS Directory Services excluding Simple AD and AD Connector.__ IAM permissions do not differentiate between AD Connector and Simple AD so "ds:*" was excluded
