FROM rust:slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y git build-essential openssl libssl-dev libc6-dev clang libclang-dev ca-certificates curl && \
    curl -sS https://webi.sh/yq | sh

WORKDIR /start-os
RUN git clone https://github.com/Start9Labs/start-os.git --branch sdk . && \
    git submodule update --init --recursive && \
    cd backend && \
    export RUSTFLAGS="" && \
    export OS_ARCH=$(uname -m) && \
    ./install-sdk.sh

# Get the path to start-cli and start-sdk using which
RUN SDK_PATH=$(which start-sdk) \
    && echo "export PATH=\$PATH:$SDK_PATH" >> /etc/profile

# Reload the profile to apply the changes
RUN . /etc/profile

WORKDIR /github/workspace

