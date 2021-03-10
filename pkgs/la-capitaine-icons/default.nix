{ fetchFromGitHub, runCommandNoCC, inkscape, gtk3, version ? "0.6.1" }:
runCommandNoCC "la-capitaine-icons-${version}"
{
  src = fetchFromGitHub {
    owner = "keeferrourke";
    repo = "la-capitaine-icon-theme";
    rev = "acedb4717717b81c4827753dc55958c425dde24c";
    sha256 = "1q8y06i0dqbnf5s21j7506pfgmwip724nlnd4ia7c429f4nxvq6h";
    # date = 2021-03-06T00:34:04+00:00;
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
        inkscape --export-background-opacity=0 \
          --export-type=png \
          --export-height=$height \
          -o $outdir/$basename.png \
          $basename.svg
      done
    done
  ''
