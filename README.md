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


