#!/bin/bash
set -ex

IMAGE_NAME=114272735376.dkr.ecr.us-east-1.amazonaws.com/summit-demo:"$SUMMIT_STACK_NAME"

echo "prebuild"
eval $(aws ecr get-login --region $AWS_DEFAULT_REGION)

echo "build"
docker build -t "$IMAGE_NAME" ./api

echo "post build"
docker push "$IMAGE_NAME"
