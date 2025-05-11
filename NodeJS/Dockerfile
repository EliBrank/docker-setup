# Use Ubuntu 25.04 as the base image
FROM ubuntu:25.04

# Set the timezone and locale
ENV TZ=America/Chicago
ENV SHELL /bin/bash
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set the working directory to /root
WORKDIR /root

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo curl git build-essential fontconfig \
    unzip locales xclip pkg-config libssl-dev libffi-dev ripgrep \
    python3.13-venv \
    fzf fd-find wl-clipboard \
    libxml2-dev libxslt1-dev zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Generate locale
RUN locale-gen en_US.UTF-8

# Install the latest Neovim from GitHub releases
RUN NEOVIM_VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"tag_name": "\K.*?(?=")') && \
    curl -LO https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux-x86_64.tar.gz && \
    tar xzf nvim-linux-x86_64.tar.gz && \
    cd nvim-linux-x86_64 && \
    cp -r bin/* /usr/local/bin/ && \
    cp -r lib/* /usr/local/lib/ && \
    cp -r share/* /usr/local/share/ && \
    cd .. && \
    rm -rf nvim-linux-x86_64 nvim-linux-x86_64.tar.gz

# Install lazygit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit /usr/local/bin && \
    rm -rf lazygit lazygit.tar.gz

# Install fd
# RUN FD_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/fd/releases/latest" | grep -Po '"tag_name": "\K[^"]*') && \
#     curl -Lo fd.tar.gz "https://github.com/sharkdp/fd/releases/download/${FD_VERSION}/fd-${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz" && \
#     tar xf fd.tar.gz && \
#     install fd-${FD_VERSION}-x86_64-unknown-linux-gnu/fd /usr/local/bin && \
#     rm -rf fd.tar.gz fd-${FD_VERSION}-x86_64-unknown-linux-gnu

# Install fzf
# RUN FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "\K[^"]*') && \
#     curl -Lo fzf.tar.gz "https://github.com/junegunn/fzf/releases/download/${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" && \
#     tar xf fzf.tar.gz && \
#     install fzf /usr/local/bin && \
#     rm -rf fzf fzf.tar.gz && \
#     # Also install fzf scripts and completion
#     git clone --depth 1 --branch "${FZF_VERSION}" https://github.com/junegunn/fzf.git ~/.fzf && \
#     ~/.fzf/install --all

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install FiraCode Nerd Font
RUN mkdir -p ~/.local/share/fonts && \
    curl -Lo Firacode.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip" && \
    unzip Firacode.zip -d ~/.local/share/fonts && \
    fc-cache -fv && \
    rm Firacode.zip

# Clone personal LazyVim starter configuration
RUN git clone https://github.com/EliBrank/eli-lazyvim ~/.config/nvim

# Set the working directory to "Code"
WORKDIR /root/Code

# Copy additional content
COPY ./content /root/Code

# Copy .bashrc file
COPY bashrc /root/.bashrc
