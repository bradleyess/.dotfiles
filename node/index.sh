#!/bin/bash

sudo -v

packages=(
    fkill
    alfred-fkill
    vtop
    eslint
    typescript
    tslint
    webpack
    ndb
    np
    release
)

if test $(which yarn)
    then
    yarn add global ${packages[@]}
fi
