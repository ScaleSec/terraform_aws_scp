# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "http" "hipaa_policy" {
  url = "https://raw.githubusercontent.com/salesforce/aws-allowlister/main/examples/latest/HIPAA-AllowList-SCP.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_organizations_policy" "allow_hipaa_services_policy" {
  name        = "Allow HIPAA Services"
  description = "Only allow HIPAA services."

  content = data.http.hipaa_policy.body
}

resource "aws_organizations_policy_attachment" "allow_hipaa_services_attachment" {
  policy_id = aws_organizations_policy.allow_hipaa_services_policy.id
  target_id = var.target_id
}
