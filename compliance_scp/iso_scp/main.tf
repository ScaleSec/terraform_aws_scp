# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "template_file" "iso_policy" {
  template = file("../templates/iso.json")
}

resource "aws_organizations_policy" "allow_iso_services_policy" {
  name        = "Allow ISO Services"
  description = "Only allow ISO services as of 02/2021"

  content = data.template_file.iso_policy.rendered
}

resource "aws_organizations_policy_attachment" "allow_iso_services_attachment" {
  policy_id = aws_organizations_policy.allow_iso_services_policy.id
  target_id = var.target_id
}