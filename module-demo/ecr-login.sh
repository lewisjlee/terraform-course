#!/bin/bash
REGION="ap-northeast-2"
`aws ecr get-login-password --no-include-email --region ${REGION}`
