# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage
{ system ? builtins.currentSystem }:
let
  sources = (import ./nix/sources.nix);
  pkgs = import sources.nixpkgs { inherit system; };
  nivSrc = srcName: fetchTarball {
    inherit (sources.${srcName}) url sha256;
  };
  srcOnlyFromNiv = name: srcName: pkgs.srcOnly {
    inherit name;
    src = fetchTarball {
      inherit ((import ./nix/sources.nix).${srcName}) url sha256;
    };
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

  # Just export the source repositories
  zsh-enhancd = srcOnlyFromNiv "zsh-enhancd" "enhancd";
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

  linguist-wrapper = pkgs.callPackage ./pkgs/linguist-wrapper { };
  # The same as above
  linguist-wrapper-podman = pkgs.callPackage ./pkgs/linguist-wrapper {
    useDocker = false;
  };
  # Use Docker to build an image and run a container
  linguist-wrapper-docker = pkgs.callPackage ./pkgs/linguist-wrapper {
    useDocker = true;
  };

  la-capitaine-icons = pkgs.callPackage ./pkgs/la-capitaine-icons { };

  gif-progress = pkgs.callPackage ./pkgs/gif-progress {
    inherit system;
  };

  readability-cli = pkgs.callPackage ./pkgs/readability-cli { };

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

  # Use the same OTP version as what elixir-ls was built on.
  elixir-ls_1_8 = (pkgs.callPackage ./pkgs/elixir-ls {
    elixir = pkgs.elixir_1_8;
  }).elixir-ls_1_8;

  elixir-ls_1_9 = (pkgs.callPackage ./pkgs/elixir-ls {
    elixir = pkgs.elixir_1_9;
  }).elixir-ls_1_9;

  elixir-ls_1_10 = (pkgs.callPackage ./pkgs/elixir-ls {
    elixir = pkgs.beam.packages.erlangR23.elixir_1_10;
  }).elixir-ls_1_10;

  # TODO: Include this package once Elixir 1.11 becomes available in the latest stable channel
  #
  # elixir-ls_1_11 = (pkgs.callPackage ./pkgs/elixir-ls {
  #   elixir = pkgs.elixir_1_11;
  # }).elixir-ls_1_11;

}
