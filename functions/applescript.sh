#!/bin/bash

decompileAppleScript() {
    [ -d src/ ] || mkdir src
    osadecompile $1 > src/${1/.scpt/}.applescript
}
