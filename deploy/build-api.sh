#!/bin/bash
set -ex

service() {
  aws cloudformation describe-stacks \
    --stack-name ${SUMMIT_STACK_NAME} \
    --query 'Stacks[0].Outputs[?OutputKey==`"Service"`]  | [0].OutputValue' \
    --output text
}

stack-outputs() {
  aws cloudformation describe-stacks \
    --stack-name $1 \
    --output text \
    --query 'Stacks[0].Outputs | join(`"\n"`,[].join(`""`,[OutputKey,`"="`,OutputValue]))'
}

IMAGE_NAME=114272735376.dkr.ecr.us-east-1.amazonaws.com/summit-demo:"$SUMMIT_NAME"

echo "prebuild"
eval $(aws ecr get-login --region $AWS_DEFAULT_REGION)

echo "build"
docker build -t "$IMAGE_NAME" ./api

echo "post build"
docker push "$IMAGE_NAME"

# Bounce the service
echo 'roll the service'
while [ $(service) = "None" ]; do
  echo 'Waiting for stack to settle...'
  sleep 5
done
eval $(stack-outputs $SUMMIT_STACK_NAME)
service=$Service
cluster=$Cluster
echo "Service: $Service"
echo "Clster: $Cluster"
taskDef=$(aws ecs describe-services --service $service --cluster $cluster --output text --query 'services[0]|taskDefinition')
taskSpec=$(aws ecs describe-task-definition --task-definition $taskDef --query 'taskDefinition|{containerDefinitions:containerDefinitions,volumes:volumes,family:family}')
newTaskDef=$(aws ecs register-task-definition --cli-input-json "$taskSpec" --output text --query 'taskDefinition.taskDefinitionArn')
aws ecs update-service --service $service --cluster $cluster --task-definition $newTaskDef
