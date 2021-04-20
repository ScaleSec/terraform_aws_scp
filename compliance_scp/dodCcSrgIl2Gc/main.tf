# The below approved services are based off the list located here: https://aws.amazon.com/compliance/services-in-scope/

data "template_file" "dodccsrgil2gc_policy" {
  template = file("../templates/dodccsrgIl2Gc.json")
}

resource "aws_organizations_policy" "allow_dodccsrgil2gc_services_policy" {
  name        = "Allow DoD CC SRG IL2 (GovCloud) Services"
  description = "Only allow DoD CC SRG IL2 (GovCloud) services as of 03/2021"

  content = data.template_file.dodccsrgil2gc_policy.rendered
}

resource "aws_organizations_policy_attachment" "allow_dodccsrgil2gc_services_attachment" {
  policy_id = aws_organizations_policy.allow_dodccsrgil2gc_services_policy.id
  target_id = var.target_id
}
