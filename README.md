# Key-value using grpc

### Dependencies

- openssl
- protobuf-compiler
- libprotobuf-dev

### Building

To create the TLS certificates for HTTPS:
```
mkdir tls
cd tls
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out signreq.csr
openssl x509 -req -days 365 -in signreq.csr -signkey key.pem -out certificate.pem
```

Build the protocols and the binaries
```
cargo build --workspace --release
```

Run FIRST the gRPC server THEN the API server
```
./target/release/grpc-server
./target/release/proxy-server
```

The env variable `RUST_LOG` controls the output on the terminal, as per [`env_logger`](https://docs.rs/env_logger/0.11.3/env_logger/index.html#example)

##### Docker
Should be as easy as 
```
docker build -t kv-grpc .
docker run -it -p 8080:8080 kv-grpc
```

### Usage
The API routes are on `https://localhost:8080/store/`

Methods
- `get?<key>`
- `post`
  - Takes a multipart form with fields `key` and `value`
- `delete?<key>`


### Notes
- TLS connection between the gRPC server and the API server is not yet implemented (Tonic does nor allow complex TLS configurations to be made(yet))
- Ideally `docker-compose` should be used
- No time for tests :(