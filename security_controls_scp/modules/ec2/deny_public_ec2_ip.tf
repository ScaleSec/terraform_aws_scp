#-----security_controls_scp/modules/ec2/deny_public_ec2_ip.tf----#

## Denies Users from launching EC2s with public IPs

data "aws_iam_policy_document" "deny_ec2_public_ip_document" {
  statement {
    sid = "DenyEc2PublicIp"

    actions = [
      "ec2:RunInstances",
    ]

    resources = [
      "arn:aws:ec2:*:*:network-interface/*",
    ]

    effect = "Deny"

    condition {
      test     = "Bool"
      variable = "ec2:AssociatePublicIpAddress"

      values = [
        "true",
      ]
    }
  }
}

resource "aws_organizations_policy" "deny_ec2_public_ip" {
  name        = "Deny EC2s with Public IPs"
  description = "Denies users the ability to launch an EC2 with a public IP"

  content = data.aws_iam_policy_document.deny_ec2_public_ip_document.json
}

resource "aws_organizations_policy_attachment" "deny_ec2_public_ip_attachment" {
  policy_id = aws_organizations_policy.deny_ec2_public_ip.id
  target_id = var.target_id
}
