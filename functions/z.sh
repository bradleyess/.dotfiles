#!/usr/bin/env bash

# Change directory with 'z' and open EDITOR.
function zc() {
    _z "$1";
    code .
}