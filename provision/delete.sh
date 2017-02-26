#!/bin/bash

stackname="summit-${1:-demo}"

aws cloudformation delete-stack --stack-name $stackname

