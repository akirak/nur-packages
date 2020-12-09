{ runCommandNoCC, src, version }:
runCommandNoCC "wsl-open-${version}"
{
  inherit src;
}
  ''
    mkdir -p $out/bin
    cp $src/wsl-open.sh $out/bin/wsl-open
    chmod a+x $out/bin/wsl-open
  ''
