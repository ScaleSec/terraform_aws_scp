# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "template_file" "fedrampm_policy" {
  template = file("../templates/fedrampm.json")
}

resource "aws_organizations_policy" "allow_fedrampm_services_policy" {
  name        = "Allow FedRAMP Med Services"
  description = "Only allow FedRAMP Medium services as of 03/2021"

  content = data.template_file.fedrampm_policy.rendered
}

resource "aws_organizations_policy_attachment" "allow_fedrampm_services_attachment" {
  policy_id = aws_organizations_policy.allow_fedrampm_services_policy.id
  target_id = var.target_id
}