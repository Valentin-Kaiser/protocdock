<p align="center">
  <img src="protocdock.png" width="300">
</p>

# Docker Protocol Buffer Compiler

This is a Docker image for a bundle of the proto compiler and the following plugins, for Golang and JavaScript/TypeScript:

| Software | Version |
| -------- | ------- |
| [Protocol Buffer Compiler](https://github.com/protocolbuffers/protobuf) | 24.4 |
| [protoc-gen-go](https://google.golang.org/protobuf) | 1.31.0 |
| [protoc-gen-go-grpc](https://google.golang.org/grpc/cmd/protoc-gen-go-grpc) | 1.3.0 |
| [grpc-web](https://github.com/grpc/grpc-web) | 1.4.2 |
| [protobuf-javascript](https://github.com/protocolbuffers/protobuf-javascript) | 3.21.2 |
| [protoc-gen-doc](https://github.com/pseudomuto/protoc-gen-doc) | 1.5.1 |

## Usage

### GitHub Action

You can use this image in a GitHub Action to generate the code for your proto files:

```yaml
name: ProtocDock

on: [push]

jobs:
  compile:
    runs-on: ubuntu-latest

    steps:
    - name: ProtocDock Compile
      uses: valentin-kaiser/protocdock@master
      with:
        command: 'cd proto && rm -r ./gen/ && mkdir -p ./gen/ && protoc generic.proto --plugin=ts-protoc-gen=$PROTOC_GEN_TS_PATH --go_out=./gen/ --go-grpc_out=./gen/ --js_out="import_style=commonjs,binary:./gen/" --grpc-web_out="import_style=typescript,mode=grpcweb:./gen/" --proto_path=/app/proto'
        commit_message: '[GEN] Updated compiled proto definitions'
```

### Docker

Pull the container:

```bash
docker pull ghcr.io/valentin-kaiser/protocdock:latest
```

Run the container via compose and enter the container:

```bash
docker compose up -d
docker exec -it proto-compiler /bin/bash
```

The compose maps a volume to the `proto` folder in the root of this repository. You can now run the `protoc` command to compile your proto files.

```bash
protoc generic.proto --plugin=ts-protoc-gen=$PROTOC_GEN_TS_PATH --go_out=./gen/ --go-grpc_out=./gen/ --js_out="import_style=commonjs,binary:./gen/" --grpc-web_out="import_style=typescript,mode=grpcweb:./gen/" --proto_path=/app/proto
```

### Different versions

To use a different version of the compiler or a plugin, you have to build the image yourself. You can do this by running the following command in the root of this repository:

```bash
docker build -t protocdock:latest --build-arg <argument>=<version>  .
```

The available version arguments are:

| Argument | Default |
| -------- | ------- |
| `PROTOC_VERSION` | `24.4` |
| `PROTOC_GEN_GO_VERSION` | `1.31.0` |
| `PROTOC_GEN_GO_GRPC_VERSION` | `1.3.0` |
| `PROTOBUF_JAVASCRIPT_VERSION` | `3.21.2` |
| `GRPC_WEB_VERSION` | `1.4.2` |
| `PROTOC_GEN_DOC_VERSION` | `1.5.1` |
| --- | --- |
| `CURL_VERSION` | `7.68.0-1ubuntu2.20` |
| `GIT_VERSION` | `1:2.25.1-1ubuntu3.11` |
| `MAKE_VERSION` | `4.2.1-1.2` |
| `UNZIP_VERSION` | `6.0-25ubuntu1.1` |
| `NODE_MAJOR` | `20.x` |
| `GO_VERSION` | `1.21.3` |
| `CA_CERTIFICATES_VERSION` | `20230311ubuntu0.20.04.1` |
| `GNUPG_VERSION` | `2.2.19-3ubuntu2.2` |