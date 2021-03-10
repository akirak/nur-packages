{ runCommandNoCC, fetchFromGitHub }:
runCommandNoCC "wsl-open-0"
{
  src = fetchFromGitHub {
    owner = "4U6U57";
    repo = "wsl-open";
    rev = "6419bb63845acd0533f30bdc8258f8df5fbb25cb";
    sha256 = "00d2f7cw5mqj6czidlc6xwih0id33kf9c94k8nis28k0fw6s8ska";
    # date = 2021-01-20T04:46:45+00:00;
  };
}
  ''
    mkdir -p $out/bin
    cp $src/wsl-open.sh $out/bin/wsl-open
    chmod a+x $out/bin/wsl-open
  ''
