
stackname="summit-${1:-demo}"
watch -g "aws cloudformation describe-stacks --stack-name $stackname | grep StackStatus"

echo -n 'App Site: '
aws cloudformation describe-stacks --stack-name summit-charlie --query 'Stacks[0].Outputs[?OutputKey==`Link`].OutputValue| @[0]' --output text
