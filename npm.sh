#!/bin/bash

if test ! "$(which npm)"; then
    echo "NPM not found!"
    exit 1
fi

globalPackages=(
    dockly
)

npm i -g "${globalPackages[@]}"
