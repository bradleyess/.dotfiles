#!/usr/bin/env bash

hideDesktop() {
    defaults write com.apple.finder CreateDesktop false
    killall Finder
}

showDesktop() {
    defaults write com.apple.finder CreateDesktop true
    killall Finder
}