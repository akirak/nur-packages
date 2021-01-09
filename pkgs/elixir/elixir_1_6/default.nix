{ beam, erlang, rebar }:

(beam.lib.callElixir ./1.6.6.nix {
  inherit erlang;
  debugInfo = true;
}).overrideDerivation (_: {
  # Override preBuild to prevent errors.
  # Based on nix-beam
  # https://github.com/jechol/nix-beam/blob/master/pkgs/development/interpreters/elixir/generic-builder.nix
  preBuild = ''
    # The build process uses ./rebar. Link it to the nixpkgs rebar
    rm -vf rebar
    ln -s ${rebar}/bin/rebar rebar

    substituteInPlace Makefile \
      --replace "/usr/local" $out
  '';
})
