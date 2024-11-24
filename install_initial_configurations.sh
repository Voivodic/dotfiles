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

# Check if unzip is installed
if ! command -v unzip &> /dev/null
then
    echo "unzip is not installed. Please, install it to processd."
    exit 1
fi

# Check if make is installed
if ! command -v make &> /dev/null
then
    echo "make is not installed. Please, install it to procced."
    exit 1
fi

# Check if gcc is installed
if ! command -v gcc &> /dev/null
then
    echo "gcc is not installed. Please, install it to proceed."
    exit 1
fi

# ncurses
{
    {
        # Download and extract ncurses source code
        wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.3.tar.gz
        tar -xzf ncurses-6.3.tar.gz
        cd ncurses-6.3

        # Configure, compile, and install ncurses
        ./configure --prefix=$HOME/.local --with-shared --without-debug --enable-widec
        make
        make install
        cd ..
    } && {
        # Update environment variables
        export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
        export PATH=$HOME/.local/bin:$PATH
        export CFLAGS=-I$HOME/.local/include
        export LDFLAGS=-L$HOME/.local/lib

        # Update .bashrc
        echo 'export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
        echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
        echo 'export CFLAGS="-I$HOME/.local/include"' >> ~/.bashrc
        echo 'export LDFLAGS="-L$HOME/.local/lib"' >> ~/.bashrc
    }
} && {
    rm -r ncurses*
    echo -e "\n\n\n ncurses installed! \n\n\n" 
} || {
    echo "An error ocurred while trying to install ncurses!"
    exit 1
}

# zsh
{
    {
        # Download and extract Zsh source code
        wget https://sourceforge.net/projects/zsh/files/latest/download -O zsh.tar.xz
        tar -xf zsh.tar.xz
        cd zsh-*

        # Configure, compile, and install Zsh
        ./configure --prefix=$HOME/.local
        make
        make install
        cd ..
    } && {
        # Add Zsh to PATH and set it as the default shell
        echo 'exec $HOME/.local/bin/zsh -l' >> ~/.bashrc
    }
} && {
    rm -r zsh*
    echo -e "\n\n\n zsh installed! \n\n\n" 
} || {  
    echo "An error ocurred while trying to install zsh!"
    exit 1
}

# Install the nerd fonts
{
    mkdir -p ~/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
    unzip Hack.zip
    mv HackNerdFont-Regular.ttf ~/.local/share/fonts/
} && {
    rm -r Hack*
    echo -e "\n\n\n nerd fonts installed! \n\n\n" 
} || {  
    echo "An error ocurred while trying to install nerd fonts!"
    exit 1
}

# Install oh my zsh
{
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
} && echo -e "\n\n\n oh my zsh installed! \n\n\n" || {
    echo "An error ocurred while trying to install oh my zsh!"
    exit 1
}

# Install powerlevel10k
{
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
} && echo -e "\n\n\n powerlevel10k installed! \n\n\n" || {
    echo "An error ocurred while trying to install powerlevel10k!"
    exit 1
}

# Install zsh syntax highlighting
{
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
} && echo -e "\n\n\n zsh syntax highlighting installed! \n\n\n" || {
    echo "An error ocurred while trying to install zsh syntax highlighting!"
    exit 1
}

# Install zsh auto-suggestion
{
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
} && echo -e "\n\n\n zsh autosuggestions installed! \n\n\n" || {
    echo "An error ocurred while trying to install zsh auto-suggestion!"
    exit 1
}

# Update the plugins on zshrc
sed -i 's|plugins=(git)|plugins=(git zsh-syntax-highlighting  zsh-autosuggestions)|' ~/.zshrc && echo -e "\n\n\n plugings updatted! \n\n\n" || {
    echo "An error ocurred while trying to update the plugins on .zshrc!"
    exit 1
}

# Source the new rc files (at this point you will configure your zsh terminal) 
{
    source ~/.bashrc
    source ~/.zshrc
} && echo -e "bashrc and zshrc sourced!" || {
    echo "An error ocurred while trying to source bashrc and zshrc!"
    exit 1
}
