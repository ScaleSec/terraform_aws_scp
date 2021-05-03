# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "http" "iso_policy" {
  url = "https://raw.githubusercontent.com/salesforce/aws-allowlister/main/examples/latest/ISO-AllowList-SCP.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_organizations_policy" "allow_iso_services_policy" {
  name        = "Allow ISO Services"
  description = "Only allow ISO services."

  content = data.http.iso_policy.body
}

resource "aws_organizations_policy_attachment" "allow_iso_services_attachment" {
  policy_id = aws_organizations_policy.allow_iso_services_policy.id
  target_id = var.target_id
}
