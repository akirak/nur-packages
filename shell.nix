let
  pkgs = import (import ./nix/sources.nix).nixpkgs { };
  pre-commit = import ./nix/pre-commit.nix { inherit pkgs; };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.shellcheck
  ];

  shellHook = pre-commit.shellHook;
}
