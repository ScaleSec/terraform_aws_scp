# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "template_file" "dodccsrgil2ew_policy" {
  template = file("../templates/dodCcSrgIl2Ew.json")
}

resource "aws_organizations_policy" "allow_dodccsrgil2ew_services_policy" {
  name        = "Allow DoD CC SRG IL2 (East/West) Services"
  description = "Only allow DoD CC SRG IL2 (East/West) services as of 03/2021"

  content = data.template_file.dodccsrgil2ew_policy.rendered
}

resource "aws_organizations_policy_attachment" "allow_dodccsrgil2ew_services_attachment" {
  policy_id = aws_organizations_policy.allow_dodccsrgil2ew_services_policy.id
  target_id = var.target_id
}
