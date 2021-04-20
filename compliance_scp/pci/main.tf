# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "template_file" "pci_policy" {
  template = file("../templates/pci.json")
}

resource "aws_organizations_policy" "allow_pci_services_policy" {
  name        = "Allow PCI Services"
  description = "Only allow PCI services as of 03/2021"

  content = data.template_file.pci_policy.rendered
}

resource "aws_organizations_policy_attachment" "allow_pci_services_attachment" {
  policy_id = aws_organizations_policy.allow_pci_services_policy.id
  target_id = var.target_id
}
