{ runCommandNoCC }:
runCommandNoCC "wsl-open-0"
  {
    src = pkgs.fetchFromGitHub {
      owner = "4U6U57";
      repo = "wsl-open";
      rev = "9000402a2edddf353984a901fc7e8b4cd425e341";
      sha256 = "0lj6isx7hp7kdj8rrpv5zffdpxi13mpjxmy4gbhmrq3hz5jl45b8";
      # date = 2019-04-16T19:33:28-07:00;
    };
  }
  ''
    mkdir -p $out/bin
    cp $src/wsl-open.sh $out/bin/wsl-open
    chmod a+x $out/bin/wsl-open
  ''
