#!/bin/bash
set -ex

content-bucket() {
  aws cloudformation describe-stacks \
    --stack-name ${SUMMIT_STACK_NAME} \
    --query 'Stacks[0].Outputs[?OutputKey==`"ContentStore"`]  | [0].OutputValue' \
    --output text
}

echo "pre build"
cd website
npm install

echo "build"
npm run build

echo "post build"
cd ..
while [ $(content-bucket) = "None" ]; do
  echo 'Waiting for stack to settle...'
  sleep 5
done

aws s3 cp \
   --recursive \
   --cache-control 'max-age=31536000' \
   $(dirname $0)/../website/build/ \
   "s3://$(content-bucket)/"


