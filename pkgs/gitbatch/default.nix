{ runCommandNoCC
, version
, src
}:
runCommandNoCC "gitbatch-${version}"
{
  inherit src;
}
  ''
    mkdir -p $out/bin
    install -t $out/bin $src/gitbatch
  ''
