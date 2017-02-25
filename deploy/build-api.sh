#!/bin/bash
set -ex

IMAGE_NAME=114272735376.dkr.ecr.us-east-1.amazonaws.com/summit-demo:"$SUMMIT_STACK_NAME"

echo "build"
cd api
docker build -t "$IMAGE_NAME"

echo "post build"
docker push "$IMAGE_NAME"
