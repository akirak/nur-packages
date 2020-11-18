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

  eclipse-jee =
    let
      # TODO: Allow choosing a different site
      site = "https://ftp.jaist.ac.jp/pub";
      mkUrl = { release, platform }: "${site}/eclipse/technology/epp/downloads/release/${release}/R/eclipse-jee-${release}-R-${platform}.tar.gz";
      srcForPlatform = { release, platform, sha256 }: fetchTarball {
        url = mkUrl { inherit release platform; };
        inherit sha256;
      };
    in
    if builtins.currentSystem == "x86_64-linux"
    then
      pkgs.callPackage ./pkgs/eclipse-jee
        {
          src = srcForPlatform {
            release = "2020-09";
            platform = "linux-gtk-x86_64";
            sha256 = "0563va51n9bf4bz2p57hj5ghs02pxgacikpzxcbnnnw78m6sb2rs";
          };
        }
    else throw "Unsupported system";
}
