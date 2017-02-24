#!/bin/bash


content-bucket() {
  aws cloudformation describe-stacks \
    --stack-name ${SUMMIT_STACK_NAME} \
    --query 'Stacks[0].Outputs[?OutputKey==`"ContentStore"`]  | [0].OutputValue' \
    --output text
}

aws s3 cp \
   --recursive \
   --cache-control 'max-age=31536000' \
   $(dirname $0)/../website/build/ \
   "s3://$(content-bucket)/"
