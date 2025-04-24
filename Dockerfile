##############################
## Build dev relay
##############################
FROM rust:latest AS rust-builder

# Update certs and pull the realy source code
RUN update-ca-certificates && git clone -b release https://github.com/BitcreditProtocol/bcr-relay.git

WORKDIR /bcr-relay

RUN cargo build --release

##############################
## Create dev image for docker compose
##############################
FROM ubuntu:22.04

RUN apt-get update && \
  apt-get install -y ca-certificates libpq5 && \
  apt-get clean

WORKDIR /relay

# Copy binary release
COPY --from=rust-builder /bcr-relay/target/release/bcr-relay ./bcr-relay

RUN chmod +x /relay/bcr-relay

# Expose server port
EXPOSE 8080

CMD ["/relay/bcr-relay", "--listen-address=0.0.0.0:8080"]
