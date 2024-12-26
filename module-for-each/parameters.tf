# 정적 변수나 map, list를 선언할 때 local 구문을 사용
# 여기는 my_parameters라는 map 정의
locals {
  my_parameters = {
    environment = "development"
    version     = "1.0"
    mykey       = "myvalue"
  }
}

module "parameters" {
  for_each = local.my_parameters
  source   = "./ssm-parameter"
  name     = each.key
  value    = each.value
}

# 하위 ssm-parameter 모듈의 출력값은 arn이다.
output "all-my-parameters" {
  value = { for k, parameter in module.parameters: k => parameter.arn }
}
