#!/bin/bash
set -ex

IMAGE_NAME=114272735376.dkr.ecr.us-east-1.amazonaws.com/summit-demo:"$SUMMIT_NAME"

echo "prebuild"
eval $(aws ecr get-login --region $AWS_DEFAULT_REGION)

echo "build"
docker build -t "$IMAGE_NAME" ./api

echo "post build"
docker push "$IMAGE_NAME"

# Bounce the service
service=$SUMMIT_ECS_SERVICE
cluster=$SUMMIT_ECS_CLUSTER
eval $(stack-outputs $SUMMIT_STACK_NAME)
taskDef=$(aws ecs describe-services --service $service --cluster $cluster --output text --query 'services[0]|taskDefinition')
taskSpec=$(aws ecs describe-task-definition --task-definition $taskDef --query 'taskDefinition|{containerDefinitions:containerDefinitions,volumes:volumes,family:family}')
newTaskDef=$(aws ecs register-task-definition --cli-input-json "$taskSpec" --output text --query 'taskDefinition.taskDefinitionArn')
aws ecs update-service --service $service --cluster $cluster --task-definition $newTaskDef
