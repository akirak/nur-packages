{ src, fetchFromGitHub, runCommandNoCC, inkscape, gtk3, version ? "0.6.1" }:
runCommandNoCC "la-capitaine-icons-${version}"
{
  src = fetchFromGitHub {
    owner = "keeferrourke";
    repo = "la-capitaine-icon-theme";
    rev = "0299ebbdbbc4cb7dea8508059f38a895c98027f7";
    sha256 = "050w5jfj7dvix8jgb3zwvzh2aiy27i16x792cv13fpqqqgwkfpmf";
    # date = 2019-07-13T15:37:21+00:00;
  };
  buildInputs = [ inkscape ];
  nativeBuildInputs = [ gtk3 ];
}
  ''
    cd $src/apps/scalable
    for basename in xorg; do
      for height in 32 48 64 96 128; do
        outdir=$out/share/icons/favorites/"$height"x"$height"/apps
        mkdir -p $outdir
        inkscape -z --export-background-opacity=0 \
          --export-height=$height \
          --export-png=$outdir/$basename.png \
          --file=$basename.svg
      done
    done
  ''
