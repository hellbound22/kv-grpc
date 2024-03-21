FROM rust:1.70

WORKDIR /usr/src/teonite-task
COPY . .


RUN cargo build --release

EXPOSE 8080

CMD ["./target/release/teonite-task"]