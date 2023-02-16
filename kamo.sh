#!usr/bin/env bash

create_links() {
  ln -sf ~/.zshrc ~/.dotfiles/.zshrc
  ln -sf ~/.tmux ~/.dotfiles/.tmux
  ln -sf ~/.tmux.conf ~/.dotfiles/.tmux.conf
  ln -sf ~/nvim/ ~/.dotfiles/.config
  ln -sf ~/.ideavimrc ~/.dotfiles/.ideavimrc
  ln -sf ~/.gitconfig ~/.dotfiles/.gitconfig
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


remove_dotfiles() {
  # TODO write script to clean all dotfiles most for testing purpose
}
