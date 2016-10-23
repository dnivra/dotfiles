#!/bin/sh

# Shell script to setup dotfiles and everything else required

# Directory and repo for dotfiles
dotfiles_dir=$HOME/dotfiles
dotfiles_repo=https://github.com/dnivra/dotfiles.git

# git configuration
git_editor=nvim
#git_email=<insert email>
#git_name=<insert name>

# ipython configuration
ipython_dir=$HOME/.ipython/profile_default

# ptpython configuration
ptpython_dir=$HOME/.ptpython

# konsole configuration
konsole_dir=$HOME/.kde/share/apps/konsole

# Directory and repo for oh-my-zsh
oh_my_zsh_dir=$HOME/.oh-my-zsh
oh_my_zsh_repo=https://github.com/robbyrussell/oh-my-zsh.git

# Directory and repo for syntax highlighting plugin
syntax_highlight_dir=$oh_my_zsh_dir/custom/plugins/zsh-syntax-highlighting
syntax_highlight_repo=https://github.com/zsh-users/zsh-syntax-highlighting.git

# Packages to install
packages="build-essential curl cmake python-dev python-pip python3-pip gdb git "
packages=$packages"software-properties-common vim-nox xclip zsh"

# PEDA configuration
peda_dir=$HOME/peda
peda_repo=https://github.com/zachriggle/peda.git

# Pip packages to install
pip2_packages="flake8 ipython isort neovim pip ptpython virtualenvwrapper"
pip3_packages="ipython pip ptpython youtube-dl"

# Stack Haskell packages to install
stack_packages="ghc-mod hdevtools hlint"

# vim and neovim configuration
vim_dir=$HOME/.vim
nvim_dir=$HOME/.config/nvim

if [ -z $git_name ] || [ -z $git_email ]
then
    echo "Please set both git_name and git_email variables in install script and re-run it"
    exit
fi
exit

# Save backups to $HOME/backups/$epoch
epoch=$(date +%s)
backup_dir=$HOME/backups/$epoch
echo "Backup directory set to $backup_dir"
mkdir -p $backup_dir

echo "Please have a backup of existing dotfiles so that recovery is possible if something goes wrong"
echo "Press Enter key to continue"
read a

echo "Updating package lists"
sudo apt-get update
if [ $? -ne 0 ]; then
    echo "Package lists update failed. Aborting."
    exit 1
fi
echo "Installing packages $packages. Won't work on systems without apt-get."
sudo apt-get install --yes $packages

echo "Installing neovim and haskell stack"
echo "Adding neovim PPA"
sudo add-apt-repository -y ppa:neovim-ppa/unstable

echo "Adding FPComplete's repository for Haskell stack."
distro_code=$(lsb_release -c | cut -f 2)
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
echo 'deb http://download.fpcomplete.com/ubuntu '$distro_code' main'|sudo tee \
    /etc/apt/sources.list.d/fpco.list

echo "Installing"
sudo apt-get update
sudo apt-get install --yes neovim stack

echo "Mapping vi to nvim"
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --set vi /usr/bin/nvim

echo "Installing pip packages. Might fail on non-Ubuntu machines."
sudo pip2 install --upgrade $pip2_packages
sudo pip3 install --upgrade $pip3_packages

# Git configuration setup
echo "Setting up git configuration"
git config --global user.name $git_name
git config --global user.email $git_email
git config --global core.editor $git_editor

if [ -d $dotfiles_dir ]; then
    echo "Backing up $dotfiles_dir to $backup_dir"
    mv $dotfiles_dir $backup_dir
fi
echo "Cloning dotfiles repository to $dotfiles_dir"
git clone $dotfiles_repo $dotfiles_dir

if [ -d $oh_my_zsh_dir ]; then
    echo "Backing up $oh_my_zsh_dir to $backup_dir"
    mv $oh_my_zsh_dir $backup_dir
fi

echo "Cloning oh-my-zsh to $oh_my_zsh_dir"
git clone $oh_my_zsh_repo $oh_my_zsh_dir

echo "Cloning syntax highlighting plugin to $syntax_highlight_dir"
git clone $syntax_highlight_repo $syntax_highlight_dir

# PEDA setup
if [ -d $peda_dir ]; then
    echo "Backing up $peda_dir to $backup_dir"
    mv $peda_dir $backup_dir
fi
echo "Cloning $peda_repo to $peda_dir"
git clone $peda_repo $peda_dir
if [ -f $HOME/.gdbinit ]; then
    echo "Backing up .gdbinit to $backup_dir"
    mv $HOME/.gdbinit $backup_dir
fi
echo "source $HOME/peda/peda.py" > $HOME/.gdbinit

# Dotfiles setup
echo "Setting up all dotfiles"
if [ -f $HOME/.bashrc ]; then
    echo "Backing up bashrc to $backup_dir"
    mv $HOME/.bashrc $backup_dir
fi
ln -s $dotfiles_dir/bashrc $HOME/.bashrc

if [ -f $HOME/.isort.cfg ]; then
    echo "Backing up isort.cfg to $backup_dir"
    mv $HOME/.isort.cfg $backup_dir
fi
ln -s $dotfiles_dir/isort.cfg $HOME/.isort.cfg

if [ -f $HOME/.latexmkrc ]; then
    echo "Backing up latexmkrc to $backup_dir"
    mv $HOME/.latexmkrc $backup_dir
fi
ln -s $dotfiles_dir/latexmkrc $HOME/.latexmkrc

mkdir -p $HOME/.config
if [ -f $HOME/.config/flake8 ]; then
    echo "Backing up flake8 configuration to $backup_dir"
    mv $HOME/.config/flake8 $backup_dir
fi
ln -s $dotfiles_dir/flake8.cfg $HOME/.config/flake8

if [ -f $HOME/.vimrc ]; then
    echo "Backing up vimrc to $backup_dir"
    mv $HOME/.vimrc $backup_dir
fi
ln -s $dotfiles_dir/vimrc $HOME/.vimrc

if [ -f $HOME/.ycm_extra_conf.py ]; then
    echo "Backing up ycm_extra_conf.py to $backup_dir"
    mv $HOME/.ycm_extra_conf.py $backup_dir
fi
ln -s $dotfiles_dir/ycm_extra_conf.py $HOME/.ycm_extra_conf.py

if [ -f $HOME/.zshrc ]; then
    echo "Backing up zshrc to $backup_dir"
    mv $HOME/.zshrc $backup_dir
fi
echo "source $dotfiles_dir/zsh/zshrc" > $HOME/.zshrc
echo "# Add stack haskell binaries to PATH" >> $HOME/.zshrc
echo "export PATH=\$PATH:\$HOME/.local/bin" >> $HOME/.zshrc

echo "Configuring ipython"
if [ -d $ipython_dir ]; then
    echo "Backing up $ipython_dir to $backup_dir"
    mv $ipython_dir $backup_dir
fi
mkdir -p $ipython_dir/startup
ln -s $dotfiles_dir/ipython/ipython_config.py $ipython_dir/ipython_config.py
ln -s $dotfiles_dir/ipython/useful-functions.py $ipython_dir/startup/useful-functions.py

echo "Configuring ptpython"
if [ -d $ptpython_dir ]; then
    echo "Backing up $ptpython_dir to $backup_dir"
    mv $ipython_dir $backup_dir
fi
mkdir -p $ptpython_dir
ln -s $dotfiles_dir/ptpython_config.py $ptpython_dir/config.py

echo "Configuring konsole"
if [ -d $konsole_dir ]; then
    echo "Backing up $konsole_dir to $backup_dir"
    mv $konsole_dir $backup_dir
fi
mkdir -p $konsole_dir
ln -s $dotfiles_dir/konsole/konsole.colorscheme $konsole_dir/Mine.colorscheme
ln -s $dotfiles_dir/konsole/konsole.profile $konsole_dir/Mine.profile

echo "Configuring vim and neovim"

if [ -d $vim_dir ]; then
    echo "Backing up $vim_dir to $backup_dir"
    mv $vim_dir $backup_dir
fi
mkdir -p $vim_dir
ln -s $vim_dir $nvim_dir
ln -s $dotfiles_dir/vimrc $nvim_dir/init.vim

echo "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing vim/neovim plugins"
nvim +PlugInstall +qall

echo "Setting up Haskell stack"
stack setup

echo "Installing stack packages"
stack install $stack_packages

echo "Changing login shell to zsh"
chsh -s /bin/zsh

echo "Install complete. You might want to tweak the profile used by your terminal emulator"
