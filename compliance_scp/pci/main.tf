# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "http" "pci_policy" {
  url = "https://raw.githubusercontent.com/salesforce/aws-allowlister/main/examples/latest/PCI-AllowList-SCP.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_organizations_policy" "allow_pci_services_policy" {
  name        = "Allow PCI Services"
  description = "Only allow PCI services."

  content = data.http.pci_policy.body
}

resource "aws_organizations_policy_attachment" "allow_pci_services_attachment" {
  policy_id = aws_organizations_policy.allow_pci_services_policy.id
  target_id = var.target_id
}
