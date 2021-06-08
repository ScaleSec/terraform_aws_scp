#-----security_controls_scp/modules/account/deny_region_usage.tf----#

data "aws_iam_policy_document" "region_restriction" {
  statement {
    sid = "DenyRegionUsage"

    not_actions = [
      "a4b:*",
      "acm:*",
      "aws-marketplace-management:*",
      "aws-marketplace:*",
      "aws-portal:*",
      "budgets:*",
      "ce:*",
      "chime:*",
      "cloudfront:*",
      "config:*",
      "cur:*",
      "directconnect:*",
      "ec2:DescribeRegions",
      "ec2:DescribeTransitGateways",
      "ec2:DescribeVpnGateways",
      "fms:*",
      "globalaccelerator:*",
      "health:*",
      "iam:*",
      "importexport:*",
      "kms:*",
      "mobileanalytics:*",
      "networkmanager:*",
      "organizations:*",
      "pricing:*",
      "route53:*",
      "route53domains:*",
      "s3:GetAccountPublic*",
      "s3:ListAllMyBuckets",
      "s3:PutAccountPublic*",
      "shield:*",
      "sts:*",
      "support:*",
      "trustedadvisor:*",
      "waf-regional:*",
      "waf:*",
      "wafv2:*",
      "wellarchitected:*"
    ]

    resources = [
      "*",
    ]

    effect = "Deny"

    condition {
      test     = "StringNotEqualsIgnoreCase"
      variable = "aws:RequestedRegion"
      values = var.region_lockdown
    }
  }
}

resource "aws_organizations_policy" "region_restriction" {
  name        = "Deny Region Interaction"
  description = "Deny the ability to invoke APIs in regions outside the above"

  content = data.aws_iam_policy_document.region_restriction.json
}

resource "aws_organizations_policy_attachment" "region_restriction_attachment" {
  policy_id = aws_organizations_policy.region_restriction.id
  target_id = var.target_id
}
