#!/bin/sh

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
# https://mths.be/macos
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Colors
bold="\033[1m"
reset="\033[0m"

# Current dir
DIR="$( cd "$( dirname "$0" )" && pwd )"

# enter a new step
headline() {
    echo "----------------------------"
    echo "                            "
    echo "$bold  $1                   "
    echo "                            "
    echo "----------------------------"
    echo "$reset"
}

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

headline "Hello World"

for package in $(<$DIR/.atom/packages); do
    echo "$package"
done
