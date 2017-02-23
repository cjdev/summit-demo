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

tmp=$(mktemp)
racket infrastructure.rkt > $tmp

aws cloudformation $(op)-stack \
  --stack-name $stackname \
  --template-body file://$tmp

rm $tmp
