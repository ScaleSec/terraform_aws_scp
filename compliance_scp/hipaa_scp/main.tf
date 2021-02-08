# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "template_file" "hipaa_policy" {
  template = file("../templates/hipaa.json")
}

resource "aws_organizations_policy" "allow_hipaa_services_policy" {
  name        = "Allow HIPAA Services"
  description = "Only allow HIPAA services as of 02/2021"

  content = data.template_file.hipaa_policy.rendered
}

resource "aws_organizations_policy_attachment" "allow_hipaa_services_attachment" {
  policy_id = aws_organizations_policy.allow_hipaa_services_policy.id
  target_id = var.target_id
}