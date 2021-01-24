{ fetchzip, makeWrapper, elixir, runCommandNoCC, version, elixir-version, sha256 }:
let
  src = fetchzip {
    url = "https://github.com/elixir-lsp/elixir-ls/releases/download/v${version}/elixir-ls-${elixir-version}.zip";

    inherit sha256;
    # Prevent an error "zip file must contain a single file or directory"
    stripRoot = false;
  };
in
runCommandNoCC "elixir-ls-${elixir-version}-v${version}"
{
  inherit src;
  buildInputs = [ makeWrapper ];
  propagatedBuildInputs = [ elixir ];
} ''
    share=$out/share/elixir-ls
    mkdir -p $share $out/bin
    cp $src/*.* $share

    cat > $out/bin/language_server.sh <<EOF
  #!/bin/sh
  exec $share/language_server.sh "\$@"
  EOF
    chmod +x $out/bin/language_server.sh

    substituteInPlace $share/launch.sh \
      --replace "exec elixir" "exec ${elixir}/bin/elixir"
''
