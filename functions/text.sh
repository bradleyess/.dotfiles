#!/usr/bin/env bash

clipboardToLowercase() {
    pbpaste | tr "[:upper:]" "[:lower:]" | pbcopy
}

clipboardToUppercase() {
    pbpaste | tr "[:lower:]" "[:uppercase:]" | pbcopy
}