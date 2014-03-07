#!/bin/sh
branch=$CI_BUILD_REF_NAME

if [ $branch = "master" ]; then
  echo "master";
fi

if [ $branch = "develop" ]; then
  rvm 2.1.0 do cap integration deploy;
fi

