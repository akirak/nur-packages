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
          sha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
        }
    else
      throw "Unsupported system";
}
  ''
    mkdir -p $out/bin
    install -t $out/bin $src
  ''
