#-----security_controls_scp/modules/account/main.tf----#

data "aws_iam_policy_document" "deny_region_interaction" {
  statement {
    sid = "DenyRegionDisableEnable"

    actions = [
      "account:EnableRegion",
      "account:DisableRegion",
    ]

    resources = [
      "*",
    ]

    effect = "Deny"
  }
}

resource "aws_organizations_policy" "deny_region_interaction" {
  name        = "Deny Region Interaction"
  description = "Deny the ability to enable or disable a region."

  content = "${data.aws_iam_policy_document.deny_region_interaction.json}"
}

resource "aws_organizations_policy_attachment" "deny_region_interaction_attachment" {
  policy_id = "${aws_organizations_policy.deny_region_interaction.id}"
  target_id = "${var.target_id}"
}
