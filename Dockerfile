FROM debian:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    jq \
    vim \
    nano \
    unzip \
    xz-utils \
    build-essential \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN GO_VER=$(curl -s https://go.dev/VERSION?m=text | head -1) \
    && ARCH=$(uname -m) \
    && case "$ARCH" in \
         x86_64)  GO_ARCH="linux-amd64" ;; \
         aarch64) GO_ARCH="linux-arm64"  ;; \
         *)       echo "unsupported arch: $ARCH"; exit 1 ;; \
       esac \
    && curl -fsSLo /tmp/go.tar.gz "https://go.dev/dl/${GO_VER}.${GO_ARCH}.tar.gz" \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz

ENV PATH="/usr/local/go/bin:$PATH"
ENV GOPATH="/go"
ENV PATH="$GOPATH/bin:$PATH"

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
      -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
      > /etc/apt/sources.list.d/github-cli.list \
    && apt-get update && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai@latest
