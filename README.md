# Docker Protocol Buffer Compiler

This is a Docker image for a bundle of the [Protocol Buffer Compiler](https://github.com/protocolbuffers/protobuf) and the following plugins, for golang and javascript & typescript:

- [protoc-gen-go](https://github.com/golang/protobuf/protoc-gen-go)
- [protoc-gen-go-grpc](google.golang.org/grpc/cmd/protoc-gen-go-grpc)
- [grpc-web](https://github.com/grpc/grpc-web)
- [protobuf-javascript](https://github.com/protocolbuffers/protobuf-javascript)

## Usage

Execute the Makefile to build the image and put your proto files in the `proto` directory:

```bash
make
```

or run the following command directly:

```bash
docker build -t proto-compiler:latest .
docker compose up -d
docker exec -it proto-compiler /bin/bash
```

## Github Action

You can use this image in a Github Action to generate the code for your proto files:

```yaml
name: Compile and Commit Proto with Action

on: [push]

jobs:
  compile-and-commit-proto:
    runs-on: ubuntu-latest

    steps:
    - name: Use custom proto compiler and committer action
      uses: valentin-kaiser/docker-proto-compiler@main
      with:
        # Adjust this as needed
        command: 'cd proto && make'
        commit_message: '[GEN] Updated compiled proto definitions'

```