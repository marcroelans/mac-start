#!/bin/sh
# https://mths.be/macos
# https://github.com/mzdr/macOS

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Colors
bold="\033[1m"
reset="\033[0m"

# Current dir
DIR="$( cd "$( dirname "$0" )" && pwd )"

# enter a new step
headline() {
    echo "$bold"
    echo "----------------------------"
    echo "                            "
    echo "      $1                    "
    echo "                            "
    echo "----------------------------"
    echo "$reset"
    echo ""
    echo ""
    echo ""
}

run() {
    eval $@
}

headline "Setting up your dev environment"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "


# Install homebrew
headline "Install homebrew"
run '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
run brew update

# Install atom
run brew cask install atom

# Install atom packages
for package in $(<$DIR/.atom/packages); do
    run apm install $package
done
