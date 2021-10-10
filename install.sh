#!/bin/sh

echo "Setting up your machine..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/krav/.zprofile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential
  brew install gcc
fi

# Install requirements
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install xclip xsel

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)

brew install 'ffmpeg'
brew install 'gh'
brew install 'git'
brew install 'gnupg'
brew install 'grep'
brew install 'httpie'
brew install 'hub'
brew install 'tmux'
brew install 'pkg-config' # https://github.com/driesvints/dotfiles/issues/20
brew install 'zlib' # Needed for Memcached

# Spatie Medialibrary
brew install 'jpegoptim'
brew install 'optipng'
brew install 'pngquant'
brew install 'svgo'
brew install 'gifsicle'

# Development
brew install 'php'
brew install 'php@7.4'
brew install 'php@7.3'
brew install 'composer'
brew install 'imagemagick'
brew install 'libmemcached'
brew install 'meilisearch'
brew install 'memcached'
brew install 'mysql'
brew install 'nginx'
brew install 'node'
brew install 'redis'
brew install 'yarn'
brew install 'brew-php-switcher'


# Install global Composer packages
composer global require laravel/installer beyondcode/expose tightenco/takeout

# Create a Sites directory
mkdir $HOME/dev

# Clone Github repositories
./clone.sh

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc