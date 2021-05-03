# Compliance Service Control Policies

When organizations need to meet specific compliance requirements they must be careful to only use AWS services that are also compliant with the target framework. For example, when you need to meet PCI-DSS, you must be sure to only use PCI-DSS compliant AWS services.

To only use compliant AWS services at scale, and in a safe manner, we recommend Service Control policies.

The following compliance frameworks are currently supported in terraform.

* [SOC](soc)
* [PCI](pci)
* [HIPAA](hipaa)
* [ISO](iso)
* [FedRAMP High](fedrampHigh)
* [FedRAMP Moderate](fedrampMod)
* [Include DoD CC SRG IL2 East/West](dodCcSrgIl2Ew)
* [Include DoD CC SRG IL2 GovCloud](dodCcSrgIl2Gc)
* [Include DoD CC SRG IL4 GovCloud](dodCcSrgIl4Gc)
* [Include DoD CC SRG IL5 GovCloud](dodCcSrgIl5Gc)


All SCP JSON files are sourced from Salesforce's [aws-allowlister](https://github.com/salesforce/aws-allowlister) repository which updates via a weekly cronjob.
