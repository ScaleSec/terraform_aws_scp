# pci_iam_notes

- Below are notes based off research between IAM permissions and the PCI service list located here: https://aws.amazon.com/compliance/services-in-scope/.
- Be aware that some services are not granular enough in IAM to distinguish between compliance flavors. IE: ElastiCache redis v memcached.

### These services are not in IAM 

The following services are highlighted as PCI compliant but are either not in the IAM console or are covered by another service's IAM permissions. For example, Amazon DocumentDB is highlighted as its own service but is covered by `rds:*`.

- Amazon DocumentDB (with MongoDB compatibility)
- Amazon Forecast
- Amazon S3 Transfer Acceleration
- AWS Control Tower
- AWS Lambda@Edge
- AWS Managed Services
- AWS SDK Metrics
- AWS Snowball Edge
- AWS Snowmobile

### Known Incompatabilities

- __Amazon SageMaker [excluding Public Workforce and Vendor Workforce].__ Sagemaker does not drill down into different workforces in IAM.
- __Amazon ElastiCache (Redis).__ IAM Permissions for elasticache does not differentiate between memcached and redis.
- __AWS Directory Services excluding Simple AD and AD Connector.__ IAM permissions do not differentiate between AD Connector and Simple AD so "ds:*" was excluded.
