FROM rust:slim

RUN apt-get update && \
    apt-get install -y git build-essential openssl libssl-dev libc6-dev clang libclang-dev ca-certificates curl && \
    curl -o /usr/bin/yq https://github.com/mikefarah/yq/releases/download/v4.12.2/yq_linux_amd64 && \
    chmod +x /usr/bin/yq

WORKDIR /start-os
RUN git clone https://github.com/Start9Labs/start-os.git --branch sdk . && \
    git submodule update --init --recursive && \
    cd backend && \
    export RUSTFLAGS="" && \
    export OS_ARCH=$(uname -m) && \
    ./install-sdk.sh

WORKDIR /github/workspace

