FROM registry.fedoraproject.org/fedora:latest

RUN dnf install -y --nodocs --setopt=install_weak_deps=false \
        cargo \
        cmake \
        file \
        gcc \
        gcc-c++ \
        gh \
        git \
        git-lfs \
        golang \
        gzip \
        jq \
        less \
        make \
        nano \
        nodejs \
        npm \
        procps-ng \
        python3 \
        python3-pip \
        rust-analyzer \
        ripgrep \
        tar \
        tini \
        unzip \
        vim-enhanced \
        wget \
        xz \
        yq \
    && dnf clean all

RUN npm install -g opencode-ai@latest

EXPOSE 4096
ENTRYPOINT ["tini", "--"]
CMD ["opencode", "web", "--hostname", "0.0.0.0", "--port", "4096"]
