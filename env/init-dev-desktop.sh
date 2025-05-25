cargo install cargo-binstall
cargo binstall ouch -y
cargo binstall starship -y
cargo binstall du-dust -y
cargo binstall bat -y

mkdir tmp
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-arm64.tar.gz
mkdir ~/.local/bin -p
mv nvim-linux-arm64 ~/.local/bin/nvim

wget https://github.com/jesseduffield/lazygit/releases/download/v0.51.1/lazygit_0.51.1_Linux_arm64.tar.gz
ouch d lazygit_0.51.1_Linux_arm64.tar.gz
mv lazygit_0.51.1_Linux_arm64/lazygit ~/.local/bin/
rm lazygit_0.51.1_Linux_arm64 -r

git clone https://github.com/zjp-CN/nvim-config ~/.config/nvim
cp ~/.config/nvim/env/starship.toml ~/.config/

wget https://github.com/junegunn/fzf/releases/download/v0.62.0/fzf-0.62.0-linux_amd64.tar.gz
ouch d fzf-0.62.0-linux_amd64.tar.gz
mv fzf ~/.local/bin/

# install cbmc
https://github.com/os-checker/distributed-verification/discussions/74
