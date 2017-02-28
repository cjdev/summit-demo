#!/bin/bash

stackname="summit-${1:-demo}"
watch -g \
  "aws cloudformation describe-stacks" \
  " --stack-name $stackname --query 'Stacks[0].StackStatus'"

echo -n 'App Site: '
aws cloudformation describe-stacks --stack-name $stackname --query 'Stacks[0].Outputs[?OutputKey==`Link`].OutputValue| @[0]' --output text
