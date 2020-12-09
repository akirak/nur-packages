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
          sha256 = "1glxpcyih5afb0zzq826yxhrayf91z82x3fk02iwsl5jf0kgy4dv";
        }
    else
      throw "Unsupported system";

}
  ''
    mkdir -p $out/bin
    install -t $out/bin $src/gif-progress
  ''
