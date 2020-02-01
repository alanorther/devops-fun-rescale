#!/bin/bash

if [ $# -lt 1 ]; then
  echo ""
  echo "ERROR $0: not enough arguments"
  echo "Usage: build_push_deploy.sh <ECR address or Docker registry address>"
  echo $'EXAMPLE: build_push_deploy.sh 123456789012.dkr.ecr.us-west-2.amazonaws.com/rescale\n'
  exit 2
elif [ $# -gt 1 ]; then
  echo ""
  echo 1>&2 "ERROR $0: too many arguments"
  echo "Usage: build_push_deploy.sh <ECR address or Docker registry address>"
  echo $'EXAMPLE: build_push_deploy.sh 123456789012.dkr.ecr.us-west-2.amazonaws.com/rescale\n'
  exit 2
fi

eval $(aws ecr get-login --no-include-email --region us-west-2)
docker build -t rescale .
docker tag rescale:latest $1:latest
docker push $1:latest
aws ecs update-service --cluster rescale --service rescale-service --task-definition rescale-td --force-new-deployment
