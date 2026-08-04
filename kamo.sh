#!/usr/bin/env bash

create_links() {
  ln -sf ~/.dotfiles/.zshrc ~/.zshrc
  ln -sf ~/.dotfiles/.tmux ~/.tmux
  ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
  ln -s ~/.dotfiles/nvim ~/.config/nvim
  ln -sf ~/.dotfiles/.ideavimrc ~/.ideavimrc
  ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
  ln -sf ~/.dotfiles/kitty.conf ~/.config/kitty/kitty.conf
}

isLinux() {
  echo $OSTYPE | grep -q "linux"
}

function pckg_installed {
  local install_ok="install ok installed"
  local PGK_OK=$(dpkg-query -W --showformat='"${Status}\n' $1 | grep install_ok)
  if [ "" = "$PGK_OK" ]; then
    echo $1 "not installed. Installation starting ..."
    sudo apt install $1 -y
  fi
}

#$1 filepath
#$2 URL
function pckg_download {
  curl -fsSl -o $1 $2
}

create_links

# install z
# echo "Install z"
# echo "Downloading z"
# pckg_download "~/z.sh" "https://raw.githubusercontent.com/rupa/z/master/z.sh" 

# install zsh
#if isLinux; then
#else 
#  #how to install on mac
#fi

function customEcho() {
	echo " ======================= $1 ====================== "
}

# install ozm
# TODO no need to use ozm
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	customEcho "⇣ installing ozm ⇣"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

customEcho "here"

if isLinux; then 
	echo "is linux"

	#install fnm
	 pckg_download "" "https://fnm.vercel.app/install" | bash

	#install oh-my-zsh
	pckg_download "" "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
else
	echo "is not linux"
	customEcho "⇣ Installing brew ⇣"
	if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
		echo "✅ Homebrew installed!"
		echo >> /Users/kamo93/.zprofile
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/kamo93/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"
		omz reload
		# install fnm
		customEcho "⇣ installing fnm ⇣"
		curl -fsSL https://fnm.vercel.app/install | bash
		customEcho "✅ fnm installed!"
		brew install fzf
		brew install zoxide
		brew install git-delta
		brew install neovim
		brew install tmux
	else
		echo "❌ Homebrew installation failed!"
		exit 1
	fi
	
fi

customEcho "here 2"
#   pckg_installed "zsh"
#   chsh -s $(which zsh) $(whoami)
#   # install neovim
#   sudo apt install python3-pip -y
#   apt install clang-11 -y
#   pip install cmake
#   sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

#   git clone https://github.com/neovim/neovim

#   cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
#   git switch stable
#   sudo make install
#   nvim --version
# fi

# install oh-my-zsh
# install z
# install spaceship-zsh-theme
# install delta git diff
# install fnm

# TODO write script to clean all dotfiles most for testing purpose
# remove_dotfiles() {
# }
