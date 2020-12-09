{ runCommandNoCC
}:
runCommandNoCC "gif-progress-release"
  {
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
  }
  ''
    mkdir -p $out/bin
    install -t $out/bin $src/$archive/gif-progress
  ''
