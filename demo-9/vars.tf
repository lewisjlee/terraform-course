variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    ap-northeast-2 = "ami-097e8439574e902b4"
  }
}

