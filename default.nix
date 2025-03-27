{ nixpkgs ? import <nixpkgs> {} }:

let
  pkgs = nixpkgs.pkgs;

  to_install = [
    pkgs.python312
    pkgs.python312Packages.pip
  ];
in
  to_install
