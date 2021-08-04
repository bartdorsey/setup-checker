#!/bin/bash -l

if [ -d /tmp/setup-checker ]; then
   rm -rf /tmp/setup-checker
fi

mkdir /tmp/setup-checker
git clone -q https://raw.githubusercontent.com/bartdorsey/setup-checker/main/run.sh /tmp/setup-checker

cd /tmp/setup-checker
./check.sh
cd -
