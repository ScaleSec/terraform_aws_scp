#-----security_controls_scp/modules/cloudtrail/main.tf----#
data "aws_iam_policy_document" "deny_cloudtrail_delete" {
  statement {
    sid = "DenyCloudTrailDelete"
    
    actions = [
        "cloudtrail:DeleteTrail",
      ]
    resources = [
      "*",
    ]
    effect  = "Deny"
  }
}

resource "aws_organizations_policy" "deny_cloudtrail_delete" {
  name        = "Deny CloudTrail Delete"
  description = "Deny the ability to delete CloudTrails"

  content = "${data.aws_iam_policy_document.deny_cloudtrail_delete.json}"
}
resource "aws_organizations_policy_attachment" "deny_cloudtrail_delete_attachment" {
  policy_id = "${aws_organizations_policy.deny_cloudtrail_delete.id}"
  target_id = "${var.target_id}"
}
