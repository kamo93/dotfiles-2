#!usr/bin/env bash

create_links() {
  ln -sf ./.zshrc ~/.zshrc
  ln -sf ./.tmux ~/.tmux
  ln -sf ./.tmux.conf ~/.tmux.conf
  ln -sf ./nvim/ ~/.config
  ln -sf ./.ideavimrc ~/.ideavimrc
  ln -sf ./.gitconfig ~/.gitconfig
  ln -sf ./kitty.conf ~/.config/kitty/kitty.conf
}

isLinux() {
  echo $OSTYPE | grep -q "linux"
}

create_links

if isLinux; then 
  # install neovim
  sudo apt install python3-pip -y
  apt install clang-11 -y
  pip install cmake
  sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

  git clone https://github.com/neovim/neovim

  cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
  git switch stable
  sudo make install
  nvim --version
fi

# install z
# install oh-my-zsh
# install spaceship-zsh-theme
# install delta git diff
# install fnm
# 

