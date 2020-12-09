{ mkDerivation, unzip }
mkDerivation rec {
name = "go-mono";

src = fetchurl {
url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/Go-Mono.zip";
# date = 2019-09-28T02:49:11+0900;
sha256 = "18qga9z2hwsbaxi601vkfdh8fylg7j6q6nmi5zz3h28imd5kppmr";
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
