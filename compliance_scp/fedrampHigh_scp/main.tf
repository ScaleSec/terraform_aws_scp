# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "template_file" "fedramph_policy" {
  template = file("../templates/fedramph.json")
}

resource "aws_organizations_policy" "allow_fedramph_services_policy" {
  name        = "Allow FedRAMP High Services"
  description = "Only allow FedRAMP High services as of 02/2021"

  content = data.template_file.fedramph_policy.rendered
}

resource "aws_organizations_policy_attachment" "allow_fedramph_services_attachment" {
  policy_id = aws_organizations_policy.allow_fedramph_services_policy.id
  target_id = var.target_id
}