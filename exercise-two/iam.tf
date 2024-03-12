data "aws_iam_policy_document" "nginx" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "nginx" {
  name               = "nginx_role"
  assume_role_policy = data.aws_iam_policy_document.nginx.json
  managed_policy_arns = []
}

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"

    # wildcard used for demonstration purposes; this should be locked down in a production environment to least permissive grants necessary
    Statement = [
      {
        Action = ["s3:*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

