# UBUNTU dev setup

## Setting up custom update command

```bash
echo "sudo apt update && sudo apt -y upgrade && sudo apt -y dist-upgrade && sudo apt -y autoremove && sudo apt autoclean" > update && sudo mv update /usr/local/bin/update && sudo chmod +x /usr/local/bin/update
```

## Removing unused packages

```bash
sudo apt remove --purge libreoffice* -y
sudo apt clean
sudo apt autoremove -y
sudo apt purge rhythmbox -y
sudo apt purge thunderbird -y
sudo apt purge gnome-mahjongg -y
sudo apt purge gnome-mines -y
sudo apt purge gnome-sudoku -y
sudo apt purge aisleriot -y
```

## Installing packages

```bash
sudo apt install -y python3-pip
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev
sudo apt install -y software-properties-common apt-transport-https git curl
sudo apt install -y htop
sudo apt install -y vlc nodejs npm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
nvm install v24.15.0
nvm alias default v24.15.0
git clone https://github.com/AhmadJavaidWork/dotfiles.git
```

## Neovim
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
mkdir ~/.config/nvim
ln -s ~/dotfiles/nvim/* /.config/nvim
curl -LO https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-x64.zip
unzip tree-sitter-cli-linux-x64.zip -d tree-sitter
sudo mv tree-sitter/tree-sitter /usr/local/bin
sudo chmod +x /usr/local/bin/tree-sitter
```

## Go
```bash
curl -L0 https://go.dev/dl/go1.26.2.darwin-amd64.tar.gz
tar -C /usr/local -xzf go1.26.2.linux-amd64.tar.gz

```

## Zig
```bash
curl -LO https://ziglang.org/download/0.16.0/zig-x86_64-linux-0.16.0.tar.xz
sudo tar -C /usr/local -xf zig-x86_64-linux-0.16.0.tar.xz
```

## Bitwarden
```bash
wget https://github.com/bitwarden/clients/releases/download/desktop-v2026.3.1/Bitwarden-2026.3.1-amd64.deb
sudo apt install ./Bitwarden-2026.3.1-amd64.deb

```

## Setting up zsh and oh my zsh

### Zsh
```bash
sudo apt install -y zsh
chsh -s $(which zsh)
```
### Oh my zsh
```bash
rm -rf ~/.zshrc
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
ln -s ~/dotfiles/.zshrc ~/.zshrc
source ~/.zshrc
```

## Installing Google chrome, Slack, VSCode and OnlyOffice

### Google Chrome
```bash
cd Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb\
```

### Slack
```bash
wget https://downloads.slack-edge.com/releases/linux/4.27.156/prod/x64/slack-desktop-4.27.156-amd64.deb
sudo dpkg -i slack-desktop-4.27.156-amd64.deb
rm slack-desktop-4.27.156-amd64.deb
```

### VSCode
```bash
wget https://az764295.vo.msecnd.net/stable/da76f93349a72022ca4670c1b84860304616aaa2/code_1.70.0-1659589288_amd64.deb
sudo dpkg -i code_1.70.0-1659589288_amd64.deb
rm code_1.70.0-1659589288_amd64.deb
```

### OnlyOffice
```bash
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb?_ga=2.80536148.294670451.1659856974-1207244912.1659856974
dpkg -i 'onlyoffice-desktopeditors_amd64.deb?_ga=2.80536148.294670451.1659856974-1207244912.1659856974'
rm 'onlyoffice-desktopeditors_amd64.deb?_ga=2.80536148.294670451.1659856974-1207244912.1659856974'
sudo apt --fix-broken install -y
```

Update one more time after installing above softwares
```bash
update
```

## Setting up tmux

```bash
sudo apt install tmux -y
git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
mkdir ~/.config/tmux
sudo apt install xclip
rm -rf ~/.config/tmux/tmux.conf
ln -s ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
```

Then in terminal run `tmux` command. And then press `<Ctrl+b>` and then capital `I` to install tmux plugins

## Setting up rofi
sudo apt install rofi

### Add shortcuts
name: rofi drun
command: rofi -show drun
shortcut: Super+d

name: rofi emoji
command: rofi -show emoji
shortcut: Super+e

name: rofi run
command: rofi -show run
shortcut: Super+r

name: rofi window
command: rofi -show window
shortcut: Super+w

name: tilix
command: tilix
shortcut: Super+enter

### rofi theme:
```bash
git clone https://github.com/lr-tech/rofi-themes-collection.git
mkdir -p ~/.local/share/rofi/themes/
cp -r rofi-themes-collection/themes/* ~/.local/share/rofi/themes/
```
press Super+d select rofi-theme-selector and then search "rounded-orange-dark" then press Alt+a to select the theme
```bash
cd
rm -rf rofi-themes-collection
```

## Setting up ghostty
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"
```
Paste following to ~/.config/ghostty/config.ghostty
```bash
rm -rf ~/.config/ghostty/config.ghostty
ln -s ~/dotfiles/ghostty/config.ghostty ~/.config/ghostty/config.ghostty
```

## Setting up cuda
```bash
update
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin
sudo mv cuda-ubuntu2404.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/13.2.1/local_installers/cuda-repo-ubuntu2404-13-2-local_13.2.1-595.58.03-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2404-13-2-local_13.2.1-595.58.03-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2404-13-2-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-13-2
sudo apt install cuda
```

Add this into .clangd file in your project where you want to use cuda
```bash
CompileFlags:
  Add:
    - -I/usr/loca/cuda/include
    - -x
    - cuda
```

For auto formatting c files put this in .clang-format file in your project
```bash
BasedOnStyle: LLVM
IndentWidth: 4
ColumnLimit: 100
```
