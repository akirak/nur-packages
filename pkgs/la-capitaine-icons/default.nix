{ src, runCommandNoCC, inkscape, gtk3, version ? "0.6.1" }:
runCommandNoCC "la-capitaine-icons-${version}"
{
  inherit src;
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
