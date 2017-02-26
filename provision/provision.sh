#!/bin/bash

secrets_file="$(dirname $0)/provision.penv"
if [ -f "$secrets_file" ]; then
  source "$secrets_file"
fi

: ${SUMMIT_GITHUB_TOKEN:?}
: ${OAUTH_CLIENT_ID:?}

name=${1:-demo}
stackname=summit-$name

stack-outputs() {
  aws cloudformation describe-stacks \
    --stack-name $1 \
    --output text \
    --query 'Stacks[0].Outputs | join(`"\n"`,[].join(`""`,[OutputKey,`"="`,OutputValue]))'
}

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

eval $(stack-outputs summit-network)
eval $(stack-outputs summit-deployment-cluster)
eval $(stack-outputs summit-security)

aws cloudformation $(op)-stack \
  --stack-name $stackname \
  --template-body file://$(dirname $0)/infrastructure.yml \
  --capabilities CAPABILITY_IAM \
  --parameters  \
    "ParameterKey=GithubToken,ParameterValue=$SUMMIT_GITHUB_TOKEN" \
    "ParameterKey=OAuthClientId,ParameterValue=$OAUTH_CLIENT_ID" \
    "ParameterKey=NetworkServiceSubnets,ParameterValue=\"$NetworkServiceSubnets\"" \
    "ParameterKey=LoadBalancerSecurityGroup,ParameterValue=$LoadBalancerSecurityGroup" \
    "ParameterKey=Cluster,ParameterValue=$Cluster" \
    "ParameterKey=AppName,ParameterValue=$name"

url=http://${name}.d.cjpowered.com/index.html
echo "Application URL: ${url}"
