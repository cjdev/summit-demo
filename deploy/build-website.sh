#!/bin/bash
set -ex

echo "pre build"
cd website
npm install

echo "build"
npm run build

echo "post build"
cd ..
aws s3 cp \
   --recursive \
   --cache-control 'max-age=31536000' \
   $(dirname $0)/../website/build/ \
   "s3://${SUMMIT_STATIC_BUCKET}/"
