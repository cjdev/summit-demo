#!/bin/bash

stackname="summer-demo"

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
  --template-body file://infrastructure.yml

