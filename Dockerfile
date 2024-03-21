FROM rust:1.71

WORKDIR /usr/src/teonite-task
COPY . .

RUN apt update
RUN apt install -y openssl protobuf-compiler libprotobuf-dev

RUN cargo build --workspace --release

EXPOSE 8000

CMD ["./spinup.sh"]