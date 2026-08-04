FROM registry.fedoraproject.org/fedora:latest

RUN dnf install -y --nodocs --setopt=install_weak_deps=false \
        cmake \
        diffutils \
        file \
        gcc \
        gcc-c++ \
        gh \
        git \
        git-lfs \
        golang \
        gopls \
        jq \
        less \
        make \
        nano \
        nodejs \
        npm \
        patch \
        podman-remote \
        procps-ng \
        python3 \
        python3-pip \
        ripgrep \
        tini \
        unzip \
        vim-enhanced \
        wget \
        yq \
    && dnf clean all

RUN npm install -g opencode-ai@latest

ENV OPENCODE_DISABLE_AUTOUPDATE=true

EXPOSE 4096
ENTRYPOINT ["tini", "--"]
CMD ["opencode", "web", "--hostname", "0.0.0.0", "--port", "4096"]
