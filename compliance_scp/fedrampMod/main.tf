# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "http" "fedrampm_policy" {
  url = "https://raw.githubusercontent.com/salesforce/aws-allowlister/main/examples/latest/FedRAMP_Moderate-AllowList-SCP.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_organizations_policy" "allow_fedrampm_services_policy" {
  name        = "Allow FedRAMP Mod Services"
  description = "Only allow FedRAMP Moderate services"

  content = data.http.fedrampm_policy.body
}

resource "aws_organizations_policy_attachment" "allow_fedrampm_services_attachment" {
  policy_id = aws_organizations_policy.allow_fedrampm_services_policy.id
  target_id = var.target_id
}
