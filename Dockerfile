FROM alpine:3.22

# installing base utilities
RUN apk update
RUN apk add --no-cache \
            doas \
            bash \
            gcompat \
            libstdc++ \
            build-base \
            curl \
            git \
            neovim \
            dotnet9-sdk \
            aspnetcore9-runtime

# creating user account
RUN adduser -D gbad8-dev
RUN adduser gbad8-dev wheel
RUN echo "gbad8-dev:Df1516170224*" | chpasswd
RUN echo "permit persist :wheel" >> /etc/doas.d/20-wheel.conf

# setting up the user and working directory
USER gbad8-dev
WORKDIR /home/gbad8-dev/
RUN mkdir Work Downloads

# installing NvChad
RUN git clone https://github.com/NvChad/starter ~/.config/nvim 
RUN nvim --headless "+Lazy! sync" +qa

# installing the plugins
COPY lua-plugins/* /home/gbad8-dev/.config/nvim/lua/plugins/
RUN nvim --headless \
  -c 'MasonInstallAll' \
  -c 'MasonInstall roslyn' \
  -c 'qa'

# configuring Neovim for C#
WORKDIR /home/gbad8-dev/Work/
CMD ["/bin/bash"]
