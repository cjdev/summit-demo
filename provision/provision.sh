#!/bin/bash

: ${SUMMIT_GITHUB_TOKEN:?}
: ${OAUTH_CLIENT_ID:?}

name=${1:-demo}
stackname=summit-$name

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
  --stack-name $stackname \
  --template-body file://$(dirname $0)/infrastructure.yml \
  --capabilities CAPABILITY_IAM \
  --parameters  \
    "ParameterKey=GithubToken,ParameterValue=$SUMMIT_GITHUB_TOKEN" \
    "ParameterKey=OAuthClientId,ParameterValue=$OAUTH_CLIENT_ID" \
    "ParameterKey=Name,ParameterValue=$name"
