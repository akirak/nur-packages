{ fetchurl, unzip, mkDerivation }:
mkDerivation rec {
  name = "hack-font";

  src = fetchurl {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Hack.zip";
    # date = 2019-09-28T13:33:37+0900;
    sha256 = "076l1q4kz8hmgf3hkizx21846gsfcm3ryyg6zimzl403zn1p856i";
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
