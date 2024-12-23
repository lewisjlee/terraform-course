provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami           = "ami-097e8439574e902b4"
  instance_type = "t2.micro"
}

