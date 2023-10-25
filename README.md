# Docker Protocol Buffer Compiler

This is a Docker image for a bundle of the proto compiler and the following plugins, for Golang and JavaScript & TypeScript:

| Software | Version |
| -------- | ------- |
| [Protocol Buffer Compiler](https://github.com/protocolbuffers/protobuf) | 24.4 |
| [protoc-gen-go](https://google.golang.org/protobuf) | 1.31.0 |
| [protoc-gen-go-grpc](https://google.golang.org/grpc/cmd/protoc-gen-go-grpc) | 1.3.0 |
| [grpc-web](https://github.com/grpc/grpc-web) | 1.4.2 |
| [protobuf-javascript](https://github.com/protocolbuffers/protobuf-javascript) | 3.21.2 |
| [protoc-gen-doc](https://github.com/pseudomuto/protoc-gen-doc) | 1.5.1 |

## Usage

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

## GitHub Action

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