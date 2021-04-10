{ nodejs,  stdenv, python2, utillinux, runCommand, writeTextFile, fetchurl, fetchgit,
  runCommandNoCC
}:
let
  composition = (import ./composition.nix {
    pkgs = {
      inherit stdenv python2 utillinux runCommand writeTextFile fetchurl fetchgit;
    };
    inherit nodejs;
  }).readability-cli;
in
runCommandNoCC "readability-cli"
  {
    propagateBuildInputs = [ composition ];
  } ''
    mkdir -p $out/bin
    ln -s ${composition}/bin/readable $out/bin/readable
  ''
