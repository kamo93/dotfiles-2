#!usr/bin/env bash

echo "========================== Installing kamo dotfiles ====================="

OS=$(uname)

if [ "$OS" == "Linux" ]; then
  sudo apt update
  echo "git install"
  apt-get install git-all -y
  echo "git install end version **$(git --version | sed 's/git version//g') **"
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  rm -f -R ./.dotfiles/
  ls_count=$(ls -la ./.dotfiles | wc -l)
  if (($ls_count == 0)); then
    echo "*********CLEAN SUCCED*********"
  fi
  echo "*********START CLONING DOTFILES*********"
  sudo git clone https://github.com/kamo93/dotfiles-2.git ".dotfiles"
  cd .dotfiles
  echo "execute dotfiles script"
  sh ./kamo.sh
else
  echo "It's not linux hope its not windows"
fi
