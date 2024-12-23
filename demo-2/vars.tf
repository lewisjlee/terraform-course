variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "AMIS" {
  type = map(string)
  default = {
   ap-northeast-2 = "ami-097e8439574e902b4" 
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey_demo-2"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey_demo-2.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

