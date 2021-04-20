#-----security_controls_scp/modules/s3/s3_region_lockdown.tf----#

data "aws_iam_policy_document" "s3_region_lockdown_document" {
  statement {
    sid = "S3RegionLockdown"

    actions = [
      "s3:CreateBucket",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]

    effect = "Deny"

    condition {

      test     = "StringNotLike"
      variable = "s3locationconstraint"
      values   = var.region_lockdown
    }
    condition {

      test     = "Null"
      variable = "s3locationconstraint"
      values = [
        "false",
      ]
    }
  }
}

resource "aws_organizations_policy" "s3_region_lockdown_policy" {
  name        = "Restrict S3 Regions"
  description = "Restricts the region(s) where S3 buckets can be created."

  content = data.aws_iam_policy_document.s3_region_lockdown_document.json
}

resource "aws_organizations_policy_attachment" "s3_region_lockdown_attachment" {
  policy_id = aws_organizations_policy.s3_region_lockdown_policy.id
  target_id = var.target_id
}