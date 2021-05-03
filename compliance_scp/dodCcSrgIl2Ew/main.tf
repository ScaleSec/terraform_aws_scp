# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "http" "dodccsrgil2ew_policy" {
  url = "https://raw.githubusercontent.com/salesforce/aws-allowlister/main/examples/latest/DOD_CC_SRG_IL2_EW-AllowList-SCP.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_organizations_policy" "allow_dodccsrgil2ew_services_policy" {
  name        = "Allow DoD CC SRG IL2 (East/West) Services"
  description = "Only allow DoD CC SRG IL2 (East/West)."

  content = data.http.dodccsrgil2ew_policy.body
}

resource "aws_organizations_policy_attachment" "allow_dodccsrgil2ew_services_attachment" {
  policy_id = aws_organizations_policy.allow_dodccsrgil2ew_services_policy.id
  target_id = var.target_id
}
