#!/bin/bash

eval "$(rbenv init -)"

git config --global user.email "udzura@udzura.jp"
git config --global user.name "Uchio Kondo"
bundle config set path '/var/bundle'
bundle install
bundle binstub --force omnibus

# So bad hack!!
sed -i -e 's/libffi/ffi/' "$(find /tmp/bundle -name 'software' | xargs -I{} find  {} -name 'ruby.rb')"

./bin/omnibus build "$@"
