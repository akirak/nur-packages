{ mkDerivation, unzip }:
mkDerivation rec {
  name = "hannari-mincho-font";

  src = fetchurl {
    url = "https://github.com/qothr/cabinet/blob/master/hannari.zip?raw=true";
    sha256 = "f9f7cb9c2711e04b8ad492af5d3ae11b948f1de7bec7896470b1728602010a4e";
  };

  dontBuild = true;
  buildInputs = [ unzip ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    fontDir=$out/share/fonts/truetype
    mkdir -p $fontDir
    cp *.otf $fontDir
  '';
};
