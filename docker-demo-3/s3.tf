resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-lewisjlee"

  tags = {
    Name = "Terraform state"
  }
}
