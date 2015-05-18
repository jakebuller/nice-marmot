#!/bin/bash
# -------------------------------
# Ruby Linter
# -------------------------------
echo 'Running rubocop'
ruby $(cd "$(dirname "$0")" && pwd)/rubocop.rb
if [ $? != 0 ]
then
  exit 1
fi

# -------------------------------
# RSpec
# -------------------------------
echo 'Running rspec tests'
bundle exec rspec
if [ $? != 0 ]
then
  exit 1
fi
