#!/usr/bin/bash
# git clone https://github.com/zjp-CN/nvim-config ~/.config/nvim
cp ~/.config/nvim/env/starship.toml ~/.config/

cargo install cargo-binstall
cargo binstall ouch -y
cargo binstall starship -y
cargo binstall du-dust -y
cargo binstall fd-find -y
cargo binstall bat -y

# 获取系统架构信息
ARCH=$(uname -m)

mkdir ~/.local/bin -p
mkdir tmp -p
cd tmp

if [[ "$ARCH" == "x86_64" ]]; then
  NEOVIM=nvim-linux-x86_64
  LAZYGIT=lazygit_0.51.1_Linux_x86_64
  FZF=fzf-0.62.0-linux_amd64
  GH=gh_2.76.2_linux_amd64
elif [[ "$ARCH" == "aarch64" ]]; then
  NEOVIM=nvim-linux-arm64
  LAZYGIT=lazygit_0.51.1_Linux_arm64
  FZF=fzf-0.62.0-linux_arm64
  GH=gh_2.76.2_linux_arm64
else
  echo "$ARCH is not supported"
  exit 1
fi

# neovim
wget https://github.com/neovim/neovim/releases/download/nightly/$NEOVIM.tar.gz
ouch d $NEOVIM.tar.gz
mv $NEOVIM ~/.local/bin/nvim

# lazygit
wget https://github.com/jesseduffield/lazygit/releases/download/v0.51.1/$LAZYGIT.tar.gz
ouch d $LAZYGIT.tar.gz
mv $LAZYGIT/lazygit ~/.local/bin/
rm $LAZYGIT -r

# fzf
wget https://github.com/junegunn/fzf/releases/download/v0.62.0/$FZF.tar.gz
ouch d $FZF.tar.gz
mv fzf ~/.local/bin/

# install cbmc
# https://github.com/os-checker/distributed-verification/discussions/74

# gh cli
wget https://github.com/cli/cli/releases/download/v2.76.2/$GH.tar.gz
ouch d $GH.tar.gz
mv $GH/bin/gh ~/.local/bin/
