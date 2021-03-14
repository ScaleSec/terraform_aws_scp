# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "template_file" "soc_policy" {
  template = file("../templates/soc.json")
}

resource "aws_organizations_policy" "allow_soc_services_policy" {
  name        = "Allow SOC Services"
  description = "Only allow SOC services as of 02/2021"

  content = data.template_file.soc_policy.rendered
}

resource "aws_organizations_policy_attachment" "allow_soc_services_attachment" {
  policy_id = aws_organizations_policy.allow_soc_services_policy.id
  target_id = var.target_id
}
