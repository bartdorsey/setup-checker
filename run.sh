#!/bin/bash -l

if [ -d /tmp/setup-checker ]; then
   rm -rf /tmp/setup-checker
fi

mkdir /tmp/setup-checker
git clone -q https://github.com/bartdorsey/setup-checker /tmp/setup-checker
git checkout no-exit-branch

cd /tmp/setup-checker || exit
./check.sh
cd - || exit
