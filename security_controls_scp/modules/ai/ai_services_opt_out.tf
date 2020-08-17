#-----security_controls_scp/modules/ai/ai_services_opt_out.tf----#

resource "aws_organizations_policy" "ai_services_opt_out" {
  name        = "Opt out of AI services customer content usage"
  description = "Deny the ability to use customer data for the development and continuous improvement of Amazon AI services and technologies."
  type = "AISERVICES_OPT_OUT_POLICY"
  content = <<CONTENT
  {
    "services": {
        "default": {
            "@@operators_allowed_for_child_policies": ["@@none"],
            "opt_out_policy": {
                "@@operators_allowed_for_child_policies": ["@@none"],
                "@@assign": "optOut"
            }
        }
    }
  }
CONTENT
}

resource "aws_organizations_policy_attachment" "ai_services_opt_out_attachment" {
  policy_id = aws_organizations_policy.ai_services_opt_out.id
  target_id = var.target_id
}

