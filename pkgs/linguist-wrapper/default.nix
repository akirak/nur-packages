{ runCommandNoCC
, makeWrapper
, podman
, jq
, git
}:
runCommandNoCC "linguist-wrapper"
{
  buildInputs = [
    makeWrapper
  ];
  propagatedBuildInputs = [
    podman
    jq
    git
  ];
}
  ''
    mkdir -p $out/bin
    cp ${./wrapper} $out/bin/linguist
    chmod +x $out/bin/linguist
    wrapProgram $out/bin/linguist \
      --prefix PATH : ${podman}/bin \
      --prefix PATH : ${jq}/bin \
      --prefix PATH : ${git}/bin
  ''
