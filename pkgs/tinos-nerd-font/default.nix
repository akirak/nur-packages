{ mkDerivation
, fetchurl
, unzip
}:
mkDerivation rec {
  name = "tinos";

  src = fetchurl {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Tinos.zip";
    # date = 2019-09-28T13:32:59+0900;
    sha256 = "09i4jki7qhfg76f63lvlxa3ddxgi5kx7y8xzk049z0z709k31qfg";
  };

  dontBuild = true;
  buildInputs = [ unzip ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    fontDir=$out/share/fonts/truetype
    mkdir -p $fontDir
    cp *.ttf $fontDir
  '';
}
