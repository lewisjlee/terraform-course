# ecs ec2 role
resource "aws_iam_role" "ecs-ec2-role" {
  name               = "ecs-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "ecs-ec2-role" {
  name = "ecs-ec2-role"
  role = aws_iam_role.ecs-ec2-role.name
}

resource "aws_iam_role" "ecs-consul-server-role" {
  name = "ecs-consul-server-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "ecs-ec2-role-policy" {
name   = "ecs-ec2-role-policy"
role   = aws_iam_role.ecs-ec2-role.id
policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "ecs:CreateCluster",
              "ecs:DeregisterContainerInstance",
              "ecs:DiscoverPollEndpoint",
              "ecs:Poll",
              "ecs:RegisterContainerInstance",
              "ecs:StartTelemetrySession",
              "ecs:Submit*",
              "ecs:StartTask",
              "ecr:GetAuthorizationToken",
              "ecr:BatchCheckLayerAvailability",
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchGetImage",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF

}

# ecs service role
resource "aws_iam_role" "ecs-service-role" {
name = "ecs-service-role"
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_policy_attachment" "ecs-service-attach1" {
  name       = "ecs-service-attach1"
  roles      = [aws_iam_role.ecs-service-role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

# Jenkins Instance Role Setting

resource "aws_iam_instance_profile" "jenkins-instance-role" {
  name = "jenkins-instance-role"
  role = aws_iam_role.jenkins-instance-role.name
}

resource "aws_iam_role" "jenkins-instance-role" {
name = "jenkins-instance-role"
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_policy_attachment" "jenkins-instance-role-attach1" {
  name       = "jenkins-instance-role-attach1"
  roles      = [aws_iam_role.jenkins-instance-role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy" "jenkins-instance-role-policy" {
name   = "jenkins-instance-role-policy"
role   = aws_iam_role.jenkins-instance-role.id
policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "iam:Get*",
            "iam:List*",
            "iam:PassRole"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": "ec2:*",
          "Resource": "*"
        },
        { 
          "Effect": "Allow",
          "Action": "ecs:*",
          "Resource": "*"
        },
        { 
          "Effect": "Allow",
          "Action": "elasticloadbalancing:*",
          "Resource": "*"
        }
    ]
}
EOF
}

# terraform-state bucket policy

resource "aws_s3_bucket_policy" "terraform-state-bucket-policy" {
  bucket = aws_s3_bucket.terraform-state.id
  policy = data.aws_iam_policy_document.terraform-state-bucket-policy.json
}

data "aws_iam_policy_document" "terraform-state-bucket-policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::637423605616:role/jenkins-instance-role"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.terraform-state.arn,
      "arn:aws:s3:::terraform-state-lewisjlee/*",
    ]
  }
}