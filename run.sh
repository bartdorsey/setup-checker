#!/bin/bash -l

if [ -d $HOME/setup-checker ]; then
   rm -rf $HOME/setup-checker
fi

mkdir $HOME/.setup-checker
git clone -q https://raw.githubusercontent.com/bartdorsey/setup-checker/main/run.sh ~/.setup-checker

cd ~/setup-checker
./check.sh
cd -
