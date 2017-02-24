#!/bin/bash

stackname="summer-pipeline"

op() {
    local cmd=(aws)
    cmd+=(cloudformation describe-stacks --stack-name $stackname)
    "${cmd[@]}" &> /dev/null
    if [ "$?" -eq 0 ]; then
        echo -n update
    else
        echo -n create
    fi
}

aws cloudformation $(op)-stack \
  --capabilities CAPABILITY_IAM \
  --stack-name $stackname \
  --template-body file://pipeline.yml \
  --parameters "ParameterKey=GithubUser,ParameterValue=$SUMMIT_GITHUB_USER" \
               "ParameterKey=GithubToken,ParameterValue=$SUMMIT_GITHUB_TOKEN"

