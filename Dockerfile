FROM nixos/nix:latest

WORKDIR /usr/local/src

COPY . .

RUN nix-build


