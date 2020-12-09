{ runCommandNoCC
}:
runCommandNoCC "gitbatch-0.5.0"
  rec {
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
  }
  ''
    mkdir -p $out/bin
    install -t $out/bin $src/gitbatch
  ''
