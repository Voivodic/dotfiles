#!/bin/bash
# Check the needed libraries
for pkg in wget git ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
         echo "$pkg is not installed."
    fi
done

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
{
    git clone https://github.com/neovim/neovim
    cd neovim/
    make CMAKE_BUILD_TYPE=Release
    make install
    if ! grep -qF 'export PATH=$HOME/Libraries/Initial_cofigurations/neovim/:$PATH' ~/.bashrc; then
        echo 'export PATH=$HOME/Libraries/Initial_configurarions/nvim/bin:$PATH' >> ~/.bashrc
    fi
    source ~/.bashrc
    cd ..
} && echo -e "\n\n\n Neovim installed! \n\n\n" || {
    echo "An error ocurred while trying to install neovim!"
    exit 1
}

# Configure Neovim
{
    tar -zxvf nvim_config.tar.gz -C ~/
} && {
    echo -e "\n\n\n Neovim configured! \n\n\n" 
    nvim
    } || {
    echo "An error ocurred while trying to configure Neovim!"
    exit 1
}

echo -e "\n\n\n ALL DONE! \n\n\n"
