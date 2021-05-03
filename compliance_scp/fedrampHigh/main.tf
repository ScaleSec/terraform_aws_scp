# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "http" "fedramph_policy" {
  url = "https://raw.githubusercontent.com/salesforce/aws-allowlister/main/examples/latest/FedRAMP_High-AllowList-SCP.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_organizations_policy" "allow_fedramph_services_policy" {
  name        = "Allow FedRAMP High Services"
  description = "Only allow FedRAMP High services as of 03/2021"

  content = data.http.fedramph_policy.body
}

resource "aws_organizations_policy_attachment" "allow_fedramph_services_attachment" {
  policy_id = aws_organizations_policy.allow_fedramph_services_policy.id
  target_id = var.target_id
}
