{ fetchurl, mkDerivation, unzip }:
mkDerivation rec {
  name = "hannari-mincho-font";

  src = fetchurl {
    url = "https://github.com/qothr/cabinet/blob/master/hannari.zip?raw=true";
    sha256 = "0kha0418cwmif1j8kixywwfqz50vw4x5vbwjsj54pq0i4yfcpxzr";
    # date = 2021-03-11T00:22:01+0900;
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
}
