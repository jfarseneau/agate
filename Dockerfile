FROM rust:1.46

WORKDIR /usr/src/

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/mbrubeck/agate.git

WORKDIR /usr/src/agate

RUN cargo install --path .

VOLUME ["/var/agate/content", "/var/agate/keys"]
EXPOSE 1965
CMD ["/usr/local/cargo/bin/agate", "0.0.0.0:1965", "/var/agate/content", "/var/agate/keys/cert.pem", "/var/agate/keys/key.rsa"]
