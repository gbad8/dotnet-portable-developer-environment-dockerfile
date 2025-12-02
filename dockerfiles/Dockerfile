FROM archlinux:latest

LABEL maintainer="Guilherme d'Almeida <guilhermebarros181@hotmail.com"

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
        && pacman -Scc --noconfirm

# Create a new user 'gbad8' with sudo privileges
RUN useradd -m -s /bin/bash gbad8 && \
    echo "gbad8 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the new user
USER gbad8
WORKDIR /home/gbad8
RUN mkdir Downloads Work

# Install Entity Framework
RUN dotnet tool install --global dotnet-ef --version 9.0.11

# Intall NvChad
RUN git clone https://github.com/NvChad/starter ~/.config/nvim 

# Enter Neovim to get all the instalation 
# RUN nvim --headless "+Lazy! sync" +qa

# Copy lua plugins and config files to the right directory
COPY --chown=1000:1000 lua-files/lua-plugins/* /home/gbad8/.config/nvim/lua/plugins/
COPY --chown=1000:1000 lua-files/lua-configs/* /home/gbad8/.config/nvim/lua/configs/
COPY --chown=1000:1000 lua-files/lua-neotest/init.lua /home/gbad8/.config/nvim/

# Enter Neovim to get all the instalation 
RUN nvim --headless "+Lazy! sync" +qa

# Run Mason to install all the packages
RUN nvim --headless \
  -c 'MasonInstall roslyn \
      css-lsp \
      html-lsp \
      rzls-unstable \
      lua-language-server \
      netcoredbg' \
  -c 'qa'

# Add dotnet tools to the bash profile
RUN echo 'export PATH="$PATH:$HOME/.dotnet/tools"' >> ~/.bashrc

# Default command
WORKDIR /home/gbad8/Work/
CMD ["/bin/bash"]
