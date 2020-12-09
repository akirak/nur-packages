{ mkDerivation, fetchFromGitHub }:
mkDerivation rec {
  name = "adobe-chinese";

  src = fetchFromGitHub {
    owner = "mingchen";
    repo = "mac-osx-chinese-fonts";
    rev = "c221671103172e641b7590428eef1fc9e6efa51e";
    sha256 = "0r8z0ppdpsxvl1f31yyb533pf3nizcswsncq14xbykl942911zl7";
    # date = 2013-06-30T21:48:23+08:00;
  };

  dontBuild = true;

  installPhase = ''
    fontDir=$out/share/fonts/opentype
    mkdir -p $fontDir
    cp Adobe\ Simple\ Chinese\ Fonts/Adobe*.otf $fontDir
  '';
}
