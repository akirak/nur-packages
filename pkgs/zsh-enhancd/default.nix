{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
  name = "zsh-enhancd";
  src = fetchFromGitHub {
    owner = "ab4b4r07";
    repo = "enhancd";
    rev = "f0f894029d12eecdc36c212fa3ad14f55468d1b7";
    sha256 = "1qk2fa33jn4j3xxaljmm11d6rbng6d5gglrhwavb72jib4vmkwyb";
    # date = 2020-02-11T14:27:32+09:00;
  };
  phases = [ "installPhase" ];
  # Workaround for the auto-removing issue.
  # See https://github.com/b4b4r07/enhancd/issues/123
  installPhase = ''
    mkdir -p $out
    cp -ra -t $out $src/src $src/lib $src/config.ltsv $src/init.sh
  '';
}
