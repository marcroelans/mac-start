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
echo -n "Disable the sound effects on boot (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  sudo nvram SystemAudioVolume=" "
else
    echo ""
fi

# Install homebrew
echo -n "Install homebrew (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  headline "Install homebrew"
  run '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  run brew update
else
    echo ""
fi

# Install atom
echo -n "Install atom (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  headline "Install atom"
  run brew cask install atom
else
    echo ""
fi

# Install atom packages
echo -n "Install atom packages (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  for package in $(<$DIR/.packages/atom); do
      run apm install $package
  done
else
    echo ""
fi

# Install fonts
echo -n "Install fonts(y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  headline "Install fonts"
  run brew tap caskroom/fonts

  for font in $(<$DIR/.packages/fonts); do
          run brew cask install $font
  done

else
    echo ""
fi

# Install atom peferences
echo -n "Install atom peferences (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
  run mkdir -pv ~/.atom
  run ln -sfv $DIR/.atom/config.cson ~/.atom
else
    echo ""
fi
