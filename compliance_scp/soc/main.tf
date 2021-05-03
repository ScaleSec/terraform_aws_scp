# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "http" "soc_policy" {
  url = "https://raw.githubusercontent.com/salesforce/aws-allowlister/main/examples/latest/SOC-AllowList-SCP.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_organizations_policy" "allow_soc_services_policy" {
  name        = "Allow SOC Services"
  description = "Only allow SOC services."

  content = data.http.soc_policy.body
}

resource "aws_organizations_policy_attachment" "allow_soc_services_attachment" {
  policy_id = aws_organizations_policy.allow_soc_services_policy.id
  target_id = var.target_id
}
