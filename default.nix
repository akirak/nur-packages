# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:
let
  nivSrc = srcName: fetchTarball (import ./nix/sources.nix).${srcName}.url;
  srcOnlyFromNiv = name: srcName: pkgs.srcOnly {
    inherit name;
    src = fetchTarball (import ./nix/sources.nix).${srcName}.url;
  };
  callPackageWithNivSrc = file: srcName: attrs: pkgs.callPackage file ({
    src = nivSrc srcName;
  } // attrs);
in
{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  # zsh plugins
  zsh-enhancd = callPackageWithNivSrc ./pkgs/zsh-enhancd "enhancd" { };

  # Just export the source repositories
  zsh-pure-prompt = srcOnlyFromNiv "zsh-pure-prompt" "pure";
  zsh-fzy = srcOnlyFromNiv "zsh-fzy" "zsh-fzy";
  zsh-fast-syntax-highlighting =
    srcOnlyFromNiv "zsh-fast-syntax-highlighting" "fast-syntax-highlighting";
  zsh-nix-shell = srcOnlyFromNiv "zsh-nix-shell" "zsh-nix-shell";
  zsh-colored-man-pages =
    srcOnlyFromNiv "zsh-colored-man-pages" "colored-man-pages";

  myrepos = callPackageWithNivSrc ./pkgs/myrepos "myrepos" { };
  bashcaster = callPackageWithNivSrc ./pkgs/bashcaster "bashcaster" {
    inherit (pkgs.xorg) xprop xwininfo;
  };

  git-safe-update = pkgs.callPackage ./pkgs/git-safe-update { };

  nixGL = import (nivSrc "nixGL") { };

  la-capitaine-icons = pkgs.callPackage ./pkgs/la-capitaine-icons { };

  gif-progress = pkgs.callPackage ./pkgs/gif-progress { };

  wsl-open = pkgs.callPackage ./pkgs/wsl-open { };

  xephyr-launcher = pkgs.callPackage ./pkgs/xephyr-launcher {
    inherit (pkgs.xorg) xorgserver xdpyinfo;
  };

  hannari-mincho-font = pkgs.callPackage ./pkgs/hannnari-mincho-font {
    inherit (pkgs.stdenv) mkDerivation;
  };
  adobe-chinese-font = pkgs.callPackage ./pkgs/adobe-chinese-font {
    inherit (pkgs.stdenv) mkDerivation;
  };
  go-mono-nerd-font = pkgs.callPackage ./pkgs/go-mono-nerd-font {
    inherit (pkgs.stdenv) mkDerivation;
  };
  tinos-nerd-font = pkgs.callPackage ./pkgs/tinos-nerd-font {
    inherit (pkgs.stdenv) mkDerivation;
  };
  hack-nerd-font = pkgs.callPackage ./pkgs/hack-nerd-font {
    inherit (pkgs.stdenv) mkDerivation;
  };

  elixir_1_6_erlangR20 = pkgs.callPackage ./pkgs/elixir/elixir_1_6 {
    erlang = pkgs.erlangR20;
  };

}
