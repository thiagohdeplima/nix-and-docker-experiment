let
  pkgs = import <nixpkgs> {};
in

pkgs.stdenv.mkDerivation {
  name = "application-poetry";

  src     = /usr/local/src/app;
  version = "0.1.0";

  propagatedBuildInputs = [
    pkgs.bash
    pkgs.poetry
    pkgs.python312
  ];

  buildCommand = ''
    export HOME=$out;
    export VIRTUAL_ENV=$out/.virtualenv;

    python -m venv $VIRTUAL_ENV;
    cp -r $src/* $out;

    echo "${pkgs.python312}/bin/python main.py" > $out/startup
    chmod +x $out/startup;

    cd $out;
    poetry 
    poetry install;
  '';
}
