#!/bin/bash -l

if [ -d /tmp/setup-checker ]; then
   rm -rf /tmp/setup-checker
fi

mkdir /tmp/setup-checker
git clone -q https://github.com/bartdorsey/setup-checker /tmp/setup-checker

cd /tmp/setup-checker
./check.sh
cd -
