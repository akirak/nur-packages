{ runCommandNoCC, src, perl, makeWrapper }:
runCommandNoCC "myrepos"
{
  inherit src;
  buildInputs = [ makeWrapper ];
  propagateBuildInputs = [ perl ];
} ''
  mkdir -p $out/bin
  install -t $out/bin $src/mr
  wrapProgram $out/bin/mr
''
