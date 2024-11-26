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

# Check if gcc is installed
if ! command -v gcc &> /dev/null
then
    echo "gcc is not installed. Please, install it to proceed."
    exit 1
fi

# Download and set (Hack) nerdfonts
{
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
    unzip Hack.zip
    mkdir -p ~/.local/share/fonts/
    mv *.ttf ~/.local/share/fonts/
    fc-cache -f -v
    rm Hack.zip
} && echo -e "\n\n\n Nerdfonts installed! \n\n\n" || {
    echo "An error ocurred while trying to install nerdfonts!"
    exit 1
}


# Download and set starship for the terminal configuration
{
    wget -q https://starship.rs/install.sh | sh
    if ! grep -qF 'eval "$(starship init bash)"' ~/.bashrc; then
        echo 'eval "$(starship init bash)"' >> ~/.bashrc
    fi
    rm install.sh
} && echo -e "\n\n\n Starship installed! \n\n\n" || {
    echo "An error ocurred while trying to install starship!"
    exit 1
}

# Set the starship configurations
{
    mkdir -p ~/.config/
    cp starship.toml ~/.config/
} && echo -e "\n\n\n Starship configured! \n\n\n" || {
    echo "An error ocurred while configuring starship!"
    exit 1
}

# Install neovim
#{
#    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
#    tar -xzf nvim-linux64.tar.gz
#    mv nvim-linux64 ~/.local/nvim
#    rm nvim-linux64.tar.gz
#    if ! grep -qF 'export PATH=$HOME/.local/nvim/bin:$PATH' ~/.bashrc; then
#        echo 'export PATH=$HOME/.local/nvim/bin:$PATH' >> ~/.bashrc
#    fi
#    source ~/.bashrc
#} && echo -e "\n\n\n Neovim installed! \n\n\n" || {
#    echo "An error ocurred while trying to install neovim!"
#    exit 1
#}

# Configure Neovim
#{
#    tar -zxvf nvim_config.tar.gz -C ~/
#} && {
#    echo -e "\n\n\n Neovim configured! \n\n\n" 
#    nvim
#    } || {
#    echo "An error ocurred while trying to configure Neovim!"
#    exit 1
#}

echo -e "\n\n\n ALL DONE! \n\n\n"
