terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "lewisjlee-bk"
    key = "terraform/demo4"
  }
}
