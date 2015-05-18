#!/bin/bash
# -------------------------------
# Ruby Linter
# -------------------------------
files=$(git diff --cached --name-only --diff-filter=ACMR | grep "\.rb$")
if [ "$files" != "" ]; then
    if command -v rubocop >/dev/null 2>&1; then
        rubocop -D -R ${files}
        if [ $? != 0 ]; then
          exit 1
        fi
    else
        echo >&2 "rubocop is not installed"
    fi
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
