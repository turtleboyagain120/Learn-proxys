FROM rust:1.75 as builder
WORKDIR /usr/src/vm-core
COPY . .
RUN apt-get update &amp;&amp; apt-get install -y cmake gcc
# Build natives
RUN cd ../native &amp;&amp; chmod +x build.sh &amp;&amp; ./build.sh
# Bindgen/cc for FFI
RUN cargo build --release --bin blackbox-vm

FROM debian:bookworm-slim
RUN apt-get update &amp;&amp; apt-get install -y ca-certificates libclang-dev &amp;&amp; rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/src/vm-core/target/release/blackbox-vm /usr/local/bin/
EXPOSE 8080
CMD ["blackbox-vm"]

