#/usr/bin/env sh

echo "[INFO] clone trandong293 dotfiles"
git clone https://github.com/trandong293/dotfiles.git ~/.config
git submodule update --init

storage=~/.config/._storage_

echo "[INFO] setup services"
echo "[INFO] enbale kbdrate service"
sudo cp $storage/services/kbdrate.service /usr/lib/systemd/system/
sudo systemctl enable kbdrate.service

echo "[INFO] setup symlinks"
unzip $storage/wallpapers.zip -d $storage
echo "[INFO] link to wallpapers"
ln -sf $storage/wallpapers ~/wallpapers
echo "[INFO] link to .bashrc"
ln -sf $storage/.bashrc ~/.bashrc

echo "[INFO] setup fonts"
otf_dir=~/.local/share/fonts/otf
mkdir -p $otf_dir
echo "[INFO] copt Comic Code fonts"
unzip $storage/coco.zip -d $otf_dir

echo "[INFO] setup ssh"
echo "[INFO] copy ssh keypair"
unzip $storage/ssh.zip -d ~/

echo "[INFO] setup git"
echo "[INFO] git config email, name"
git config --global user.email "trandong2932002@gmail.com"
git config --global user.name "Tran Dong"
