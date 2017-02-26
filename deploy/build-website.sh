#!/bin/bash
set -ex

echo "pre build"
cd website
npm install

echo "build"
npm run build

echo "post build"
cd ..
./deploy/publish.sh
