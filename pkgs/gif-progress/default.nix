{ version
, src
, archive
, version
, runCommandNoCC
}:
runCommandNoCC "gif-progress-${version}"
{
  inherit src archive;
}
  ''
    mkdir -p $out/bin
    install -t $out/bin $src/$archive/gif-progress
  ''
