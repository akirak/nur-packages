{ pkgs ? import <nixpkgs> { } }:
let
  sources = import ./sources.nix;
  nix-pre-commit-hooks = import sources."pre-commit-hooks.nix";
  gitignore = ./gitignore.nix { inherit pkgs; };
in
nix-pre-commit-hooks.run {
  src = gitignore.gitignoreSource ./.;
  excludes = [
    "^nix/sources\.nix$"
    "^pkgs/readability-cli/"
  ];
  hooks = {
    nixpkgs-fmt.enable = true;
    nix-linter.enable = true;
    shellcheck.enable = true;
  };
}
