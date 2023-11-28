FROM rust:slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y git build-essential openssl libssl-dev libc6-dev clang libclang-dev ca-certificates curl && \
    # curl -sLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 && chmod +x /usr/local/bin/yq && \
    curl -sS https://webi.sh/yq | sh

WORKDIR /start-os
RUN git clone https://github.com/Start9Labs/start-os.git --branch sdk . && \
    git submodule update --init --recursive && \
    cd backend && \
    export RUSTFLAGS="" && \
    export OS_ARCH=$(uname -m) && \
    ./install-sdk.sh

WORKDIR /github/workspace

