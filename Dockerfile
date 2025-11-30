# Use Arch Linux as the base image
FROM archlinux:latest

# Update system and install required packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        sudo \
        curl \
        git \
        fzf \
        ripgrep \
        unzip \
        wget \
        npm \
        dotnet-sdk \
        aspnet-runtime \
        gcc \
        neovim \
        tree \
        base-devel \
        && pacman -Scc --noconfirm

# Create a new user 'gbad8' with sudo privileges
RUN useradd -m -s /bin/bash gbad8 && \
    echo "gbad8 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the new user
USER gbad8
WORKDIR /home/gbad8

# Create common folders
RUN mkdir Downloads Documents

# Default command
CMD ["/bin/bash"]

# Intall NvChad
RUN git clone https://github.com/NvChad/starter ~/.config/nvim 

# Enter Neovim to get all the instalation 
RUN nvim --headless "+Lazy! sync" +qa

# Install Entity Framework
RUN dotnet tool install --global dotnet-ef --version 9.0.11

# Add dotnet tools to the bash profile
RUN echo 'export PATH="$PATH:$HOME/.dotnet/tools"' >> ~/.bashrc

# Install mssql-tools to use sqlcmd
WORKDIR /home/gbad8/Downloads/
RUN curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/mssql-tools.tar.gz
RUN tar -xf mssql-tools.tar.gz
WORKDIR /home/gbad8/Downloads/mssql-tools
RUN makepkg -s --noconfirm --skippgpcheck
RUN sudo pacman -U go-sqlcmd-1.8.2-1-x86_64.pkg.tar.zst --noconfirm
