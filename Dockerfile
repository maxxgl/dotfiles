FROM python:3.11

RUN apt-get update && apt-get install -y curl git-all nodejs npm tmux \
  ripgrep locales fd-find zip fzf

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
  ~/.fzf/install

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz \
  && rm -rf /opt/nvim \
  && tar -C /opt -xzf nvim-linux64.tar.gz

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') \
  && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
  && tar xf lazygit.tar.gz lazygit \
  && install lazygit /usr/local/bin

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt-get install -y \
  msodbcsql17 \
  unixodbc-dev \
  && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/*.list

RUN git config --global http.sslVerify false && git config --global credential.helper "cache --timeout=86400"
RUN npm install -g neovim

WORKDIR /root
COPY dotfiles dotfiles

RUN pwd && ls -al && ./dotfiles/setup.sh

RUN echo "set -g status-bg '#cb4b16'" >> ./dotfiles/.tmux.conf

ENV TERM="xterm-256color"

EXPOSE 80 3000 5173 8000 8080
