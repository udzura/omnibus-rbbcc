#!/bin/bash

eval "$(rbenv init -)"
./bin/omnibus build "$@"
