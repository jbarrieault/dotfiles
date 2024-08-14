#!/bin/bash

# Install brew (package manager) https://brew.sh/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Enable brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install CLIs, databases, libraries, utilities, etc.
# awscli                               https://github.com/aws/aws-cli
# bat       (pretty cat)               https://github.com/sharkdp/bat
# fastfetch (cute system info)         https://github.com/fastfetch-cli/fastfetch
# ffmpeg                               https://www.ffmpeg.org
# fzf       (fuzzy finder)              https://github.com/junegunn/fzf
# git                                  https://github.com/git/git
# go                                   https://github.com/golang/go
# jq        (JSON processor)           https://jqlang.github.io/jq/
# llvm      (needed for ruby installs) https://www.llvm.org/
# lsd       (ls improvement)           https://github.com/lsd-rs/lsd
# maccy     (clipboard manager)        https://github.com/p0deje/Maccy
# mysql                                https://dev.mysql.com/doc/
# nmap                                 https://github.com/nmap/nmap
# postgresql                           https://github.com/postgresql/postgresql
# python                               https://www.python.org
# redis                                https://redis.io/docs/latest/
# starship  (shell prompt)             https://starship.rs/
# tldr      (simplified man pages)      https://tldr.sh/
# tmux                                 https://github.com/tmux/tmux/wiki
# wget      (better web getter)        https://www.gnu.org/software/wget/
brew install awscli bat fastfetch ffmpeg fzf git go jq llvm lsd maccy mysql neovim nmap postgresql python starship tldr tmux wget

brew install --cask firefox google-chrome iterm visual-studio-code zoom

# start mysql now and restart at login
brew services start mysql

# Install Fira Code font
curl -L -o "$HOME/Downloads/FiraCode.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
unzip -o "$HOME/Downloads/FiraCode.zip" -d "$HOME/Downloads/FiraCode"
mkdir -p "$HOME/Library/Fonts"
cp "$HOME/Downloads/FiraCode"/*.ttf "$HOME/Library/Fonts"

# Install asdf to manage Node versions
brew install coreutils
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

# Install rbenv to manage Ruby versions
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
gem install bundler

curl -fsSL https://bun.sh/install | bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

xcode-select --install
