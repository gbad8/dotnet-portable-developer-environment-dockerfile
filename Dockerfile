FROM ubuntu:26.04
LABEL mantainer="Guilherme d'Almeida"
LABEL contact="contact@guilhermedalmeida.dev"

RUN apt update -y && apt upgrade -y && apt install sudo -y
RUN sudo apt install -y neovim \
  nodejs npm curl git wget tree fzf \
  gzip tar unzip \
  luarocks \
  dotnet-sdk-10.0 \
  tree-sitter-cli \
  ripgrep \
  pip \
  fd-find \
  lazygit

RUN usermod -l portabledev -d /home/portabledev -m ubuntu
RUN echo "portabledev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/portabledev \
    && chmod 0440 /etc/sudoers.d/portabledev

RUN curl -sS https://starship.rs/install.sh | sh -s -- -y
RUN echo 'eval "$(starship init bash)"' >> /root/.bashrc

RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor -o /etc/apt/keyrings/gierens.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | tee /etc/apt/sources.list.d/gierens.list \
    && chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list \
    && apt-get update && apt-get install -y eza

USER portabledev
RUN echo 'eval "$(starship init bash)"' >> ~/.bashrc
RUN echo 'alias ls="eza --long --icons --git"' >> ~/.bashrc

WORKDIR /home/portabledev
RUN mkdir Work Downloads

RUN dotnet tool install --global dotnet-ef
RUN echo 'export PATH="$PATH:$HOME/.dotnet/tools"' >> ~/.bashrc

RUN git clone https://github.com/LazyVim/starter ~/.config/nvim
RUN rm -rf ~/.config/nvim/.git
RUN nvim --headless "+Lazy! sync" +qa

COPY --chown=1000:1000 ./config/nvim/init.lua /home/portabledev/.config/nvim/init.lua
COPY --chown=1000:1000 ./config/nvim/lua/config/ /home/portabledev/.config/nvim/lua/config
COPY --chown=1000:1000 ./config/nvim/lua/plugins/ /home/portabledev/.config/nvim/lua/plugins

RUN nvim --headless "+MasonInstall roslyn html-lsp css-lsp lua-language-server netcoredbg" +qa

WORKDIR /home/portabledev/Work

EXPOSE 100/tcp
VOLUME /home/portabledev/Work

CMD ["/bin/bash", "-c", "nvim; exec /bin/bash"]
