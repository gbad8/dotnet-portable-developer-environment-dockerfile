FROM ubuntu:26.04

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

USER portabledev
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
