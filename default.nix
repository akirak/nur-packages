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

  la-capitaine-icons = pkgs.callPackage ./pkgs/la-capitaine-icons {
    src = pkgs.fetchFromGitHub {
      owner = "keeferrourke";
      repo = "la-capitaine-icon-theme";
      rev = "0299ebbdbbc4cb7dea8508059f38a895c98027f7";
      sha256 = "050w5jfj7dvix8jgb3zwvzh2aiy27i16x792cv13fpqqqgwkfpmf";
      # date = 2019-07-13T15:37:21+00:00;
    };
  };

  gitbatch = pkgs.callPackage ./pkgs/gitbatch rec {
    version = "0.5.0";
    src =
      if builtins.currentSystem == "x86_64-linux"
      then
        builtins.fetchTarball
          {
            url = "https://github.com/isacikgoz/gitbatch/releases/download/v${version}/gitbatch_${version}_linux_amd64.tar.gz";
            sha256 = "0dw34m7qlz8i64jmng8ia9mdrr7ggq92ppcq5il3xk18n5qamgyq";
          }
      else
        throw "Unsupported system";
  };

  gif-progress = pkgs.callPackage ./pkgs/gif-progress {
    version = "0";

    src =
      if builtins.currentSystem == "x86_64-linux"
      then
        builtins.fetchTarball
          {
            url = "https://github.com/nwtgck/gif-progress/releases/download/release-fix-not-moving-progress-bar/gif-progress-linux-amd64.tar.gz";
            sha256 = "139zm9bbmnayn52myfjrshmg5wagzvghqxagv4g1b2dznjrxd4vn";
            # date = 2019-12-31T04:50:01+0900;
          }
      else
        throw "Unsupported system";

    archive =
      if builtins.currentSystem == "x86_64-linux"
      then
        "gif-progress-linux-amd64"
      else
        throw "Unsupported system";
  };

}
