#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git is not installed. Please, install it to proceed."
    exit 1
fi

# Check if wget is installed
if ! command -v wget &> /dev/null
then
    echo "wget is not installed. Please, install it to procced."
    exit 1
fi

# Check if tar is installed
if ! command -v tar &> /dev/null
then
    echo "tar is not installed. Please, install it to procced."
    exit 1
fi

# Download and extract ncurses source code
wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.3.tar.gz
tar -xzf ncurses-6.3.tar.gz
cd ncurses-6.3

# Configure, compile, and install ncurses
./configure --prefix=$HOME/.local --with-shared --without-debug --enable-widec
make
make install
cd ..

# Update environment variables
echo 'export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
echo 'export CFLAGS="-I$HOME/.local/include"' >> ~/.bashrc
echo 'export LDFLAGS="-L$HOME/.local/lib"' >> ~/.bashrc
source ~/.bashrc

# Download and extract Zsh source code
wget https://sourceforge.net/projects/zsh/files/latest/download -O zsh.tar.xz
tar -xf zsh.tar.xz
cd zsh-*

# Configure, compile, and install Zsh
./configure --prefix=$HOME/.local
make
make install

# Add Zsh to PATH and set it as the default shell
echo 'exec $HOME/.local/bin/zsh -l' >> ~/.bashrc
source ~/.bashrc

