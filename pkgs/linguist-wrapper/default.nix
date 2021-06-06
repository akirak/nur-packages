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

    if ${if useDocker then "true" else "false"}; then
       substituteInPlace $out/bin/linguist \
         --replace podman docker \
         --replace localhost/ "" \
         --replace image-entry-command \
           "docker image ls --format '{{ json . }}' \"\$tag\" 2>/dev/null"
    else
       substituteInPlace $out/bin/linguist \
         --replace image-entry-command \
            "podman image ls --format=json \"\$tag\" 2>/dev/null | jq '.[0]'"
    fi

    wrapProgram $out/bin/linguist \
      --prefix PATH : ${jq}/bin \
      --prefix PATH : ${git}/bin
  ''
