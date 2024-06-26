FROM rust:1.77.2 as builder
WORKDIR /usr/src/myapp
COPY . .
RUN cargo install --path .
RUN rustup component add rustfmt

FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y extra-runtime-dependencies && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/myapp /usr/local/bin/myapp
CMD ["myapp"]