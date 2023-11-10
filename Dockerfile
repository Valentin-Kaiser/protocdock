# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt during build
ARG DEBIAN_FRONTEND=noninteractive

# Define default versions for tools needed to install Golang, Protoc, Plugins and the PATH
ARG CURL_VERSION=7.68.0-1ubuntu2.20
ARG GIT_VERSION=1:2.25.1-1ubuntu3.11
ARG MAKE_VERSION=4.2.1-1.2
ARG UNZIP_VERSION=6.0-25ubuntu1.1
ARG NODE_MAJOR=20.x
ARG GO_VERSION=1.21.3
ARG CA_CERTIFICATES_VERSION=20230311ubuntu0.20.04.1
ARG GNUPG_VERSION=2.2.19-3ubuntu2.2

# Defined default version for Protoc and Plugins
ARG PROTOC_VERSION=25.0
ARG PROTOC_GEN_GO_VERSION=1.31.0
ARG PROTOC_GEN_GO_GRPC_VERSION=1.3.0
ARG PROTOBUF_JAVASCRIPT_VERSION=3.21.2
ARG GRPC_WEB_VERSION=1.5.0
ARG PROTOC_GEN_DOC_VERSION=1.5.1

# Set environment variables for Golang, Protoc, Plugins and the PATH
ENV GOROOT=/root/.local/go 
ENV GOPATH=/root/.local 
ENV GO111MODULE=on 
ENV PROTOC_GENT_TS_PATH=/root/.local/protobuf-javascript/bin/protoc-gen-ts
ENV PATH=$GOPATH/bin:$GOROOT/bin:/root/.local/bin:$PATH:/root/.local/go/bin:/root/.local/bin

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl=${CURL_VERSION} git=${GIT_VERSION} make=${MAKE_VERSION} unzip=${UNZIP_VERSION} && \
    mkdir -p /root/.local/bin && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates=${CA_CERTIFICATES_VERSION} gnupg=${GNUPG_VERSION} && \
    mkdir -p /etc/apt/keyrings/ && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    rm -rf /var/lib/apt/lists/*

# Install Golang
RUN curl -O https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -xzf go${GO_VERSION}.linux-amd64.tar.gz -C /root/.local && \
    rm go${GO_VERSION}.linux-amd64.tar.gz

# Install Protocol Buffers Compiler
RUN curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip && \
    unzip protoc-${PROTOC_VERSION}-linux-x86_64.zip -d /root/.local && \
    rm protoc-${PROTOC_VERSION}-linux-x86_64.zip

# Install ProtoC-Gen-Go plugins
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v${PROTOC_GEN_GO_VERSION} && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v${PROTOC_GEN_GO_GRPC_VERSION}

# Install GRPC-Web
RUN curl -LO https://github.com/grpc/grpc-web/releases/download/${GRPC_WEB_VERSION}/protoc-gen-grpc-web-${GRPC_WEB_VERSION}-linux-x86_64 && \
    chmod +x protoc-gen-grpc-web-${GRPC_WEB_VERSION}-linux-x86_64 && \
    mv protoc-gen-grpc-web-${GRPC_WEB_VERSION}-linux-x86_64 /root/.local/bin/protoc-gen-grpc-web

# Install Protobuf for JavaScript
RUN curl -LO https://github.com/protocolbuffers/protobuf-javascript/releases/download/v${PROTOBUF_JAVASCRIPT_VERSION}/protobuf-javascript-${PROTOBUF_JAVASCRIPT_VERSION}-linux-x86_64.tar.gz && \
    tar -xzf protobuf-javascript-${PROTOBUF_JAVASCRIPT_VERSION}-linux-x86_64.tar.gz -C /root/.local && \
    rm protobuf-javascript-${PROTOBUF_JAVASCRIPT_VERSION}-linux-x86_64.tar.gz

# Install Protoc-Gen-Doc
RUN curl -LO https://github.com/pseudomuto/protoc-gen-doc/releases/download/v${PROTOC_GEN_DOC_VERSION}/protoc-gen-doc_${PROTOC_GEN_DOC_VERSION}_linux_amd64.tar.gz && \
    tar -xzf protoc-gen-doc_${PROTOC_GEN_DOC_VERSION}_linux_amd64.tar.gz -C /root/.local/bin && \
    chmod +x /root/.local/bin/protoc-gen-doc && \
    rm protoc-gen-doc_${PROTOC_GEN_DOC_VERSION}_linux_amd64.tar.gz

# Set the working directory
WORKDIR /app

# Define the entrypoint
ENTRYPOINT ["/bin/bash", "-l", "-c"]
