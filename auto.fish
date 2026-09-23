#!/usr/bin/env fish

sudo pacman -Syu
sudo pacman -S --needed \
  noto-fonts noto-fonts-cjk noto-fonts-emoji \
  rtkit pipewire \
  make go uv rustup clang lua-language-server \
  firefox intel-media-driver \
  nautilus xdg-desktop-portal-gtk gnome-themes-extra \
  hyprland hypridle hyprlock hyprpaper hyprpicker xdg-desktop-portal-hyprland \
  grim slurp brightnessctl fuzzel \
  feh mpv fcitx5-bamboo zathura zathura-pdf-poppler \
  fish foot tmux \
  neovim tree-sitter-cli ripgrep fd bat \
  git openssh jq less man fakeroot wl-clipboard htop unzip

set bold $(tput bold)
set norm $(tput sgr0)
function echo_bold -a msg
  echo "$bold$msg$norm"
end

###############
### CONFIGS ###
###############

echo_bold 'CONFIGS'
cd

echo '(1/4) Cloning dotfiles'
rm -rf .config
# remember to fetch unshallow after this script
git clone --depth 1 --recurse-submodules https://codeberg.org/trandong293/dotfiles .config
cd .config && git remote set-url origin ssh://git@codeberg.org/trandong293/dotfiles
cd

echo '(2/4) Sourcing new envs'
source ~/.config/fish/config.fish

echo '(3/4) Creating symlink .bash_profile'
ln -sf ~/.config/.bash_profile ~/.bash_profile

echo '(4/4) Extracting ssh key'
gpg -d ~/.config/storage/ssh.tar.gz.gpg | tar -xf - -C ~/

#############
### FONTS ###
#############

echo_bold 'FONTS'
mkdir -p ~/.local/share/fonts/ttf
mkdir -p ~/.local/share/fonts/otf
cd ~/.local/share/fonts

echo '(1/2) Extracting Comic Code font'
gpg -d ~/.config/storage/coco.tar.xz.gpg | tar -xJf - -C otf

echo '(2/2) Extracting Agave Nerd Font'
mkdir ttf/AgaveNerdFont
curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest |
  jq '.assets.[] | select(.name == "Agave.tar.xz").browser_download_url' |
  xargs curl -LO
tar -xf Agave.tar.xz -C ttf/AgaveNerdFont
rm Agave.tar.xz

###########
### AUR ###
###########

echo_bold 'AUR'
mkdir ~/aur

echo '(1/1) Processing package pnpm-bin'
git clone https://aur.archlinux.org/pnpm-bin.git aur/pnpm-bin
cd aur/pnpm-bin
makepkg && sudo pacman -U *.pkg.tar.zst

##############
### OTHERS ###
##############

echo_bold 'OTHERS'
cd

echo '(1/8) Configuring git'
git config --global user.email 'trandong2932002@gmail.com'
git config --global user.name 'Tran Dong'
git config --global core.editor 'nvim'
git config --global init.defaultBranch 'main'

echo '(2/8) Setting dark mode in gtk'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

echo '(3/8) Installing Python language servers'
uv tool install ruff
uv tool install pyrefly

echo '(4/8) Installing Go language server'
go telemetry off
go install golang.org/x/tools/gopls@latest
 
# require building nvim blink.cmp v2
echo '(5/8) Installing rustc'
rustup default stable

echo '(6/8) Removing annoying splash screeen on boot'
sudo sed -i -e '/default_options/s/^/#/' \
  -e '/default_options/s/$/\ndefault_options=""/' /etc/mkinitcpio.d/linux.preset
sudo mkinitcpio -P

echo '(7/8) Installing dotnet and roslyn-language-server'
mkdir -p ~/.local/share/dotnet
cd ~/.local/share/dotnet
curl -s https://builds.dotnet.microsoft.com/dotnet/release-metadata/releases-index.json |
  jq '."releases-index".[] | select(."support-phase" == "active")."releases.json"' |
  xargs curl -s |
  jq '.releases.[0].sdks[-1].files.[] | select(.rid == "linux-x64").url' |
  xargs curl -LO
echo *.tar.gz | sed -e 's/dotnet-sdk-\(.*\)-linux-x64.tar.gz/\1/' |
  xargs -I {} mkdir dotnet{}
tar -xf *.tar.gz -C dotnet*/
rm *.tar.gz
ln -sf dotnet*/ dotnet-current
cd
dotnet tool install -g roslyn-language-server --prerelease --source https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/index.json

echo '(8/8) Installing node, typescript, vscode-langservers-extracted'
pnpm runtime set node latest -g
pnpm install typescript -g
pnpm install @t1ckbase/vscode-langservers-extracted -g
