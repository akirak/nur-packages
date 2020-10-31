{ stdenv, fetchFromGitHub, src}:
stdenv.mkDerivation {
  name = "zsh-enhancd";
  inherit src;
  phases = [ "installPhase" ];
  # Workaround for the auto-removing issue.
  # See https://github.com/b4b4r07/enhancd/issues/123
  installPhase = ''
    mkdir -p $out
    cp -ra -t $out $src/src $src/lib $src/config.ltsv $src/init.sh
  '';
}
