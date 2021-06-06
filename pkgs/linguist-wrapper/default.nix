{ runCommandNoCC
, makeWrapper
, jq
, git
, useDocker ? false
}:
runCommandNoCC "linguist-wrapper"
{
  buildInputs = [
    makeWrapper
  ];
  propagatedBuildInputs = [
    jq
    git
  ];
}
  ''
    mkdir -p $out/bin
    cp ${./wrapper} $out/bin/linguist
    chmod +x $out/bin/linguist
    wrapProgram $out/bin/linguist \
      --set LINGUIST_WRAPPER_CONTAINER_PROGRAM ${if useDocker
                                                 then "docker"
                                                 else "podman"} \
      --set LINGUIST_WRAPPER_IMAGE_TAG_PREFIX ${if useDocker
                                                then "''"
                                                else "localhost/"} \
      --prefix PATH : ${jq}/bin \
      --prefix PATH : ${git}/bin
  ''
