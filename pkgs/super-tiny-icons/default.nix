{ fetchFromGitHub, mkDerivation, fontconfig, inkscape, gtk3 }:
mkDerivation {
  name = "super-tiny-icons";
  version = "0";

  src = fetchFromGitHub {
    owner = "edent";
    repo = "SuperTinyIcons";
    rev = "4a164116f3c9d3c88f97a81cfde288266bc23965";
    sha256 = "0yzbax6cy99mz57j12cmkpr8mzngzpykf81w5p3qnzzsbdam30m9";
    # date = 2020-12-06T20:00:19+00:00;
  };

  buildInputs = [ inkscape ];
  nativeBuildInputs = [ gtk3 fontconfig ];

  buildPhase = ''
    export XDG_CONFIG_HOME=$PWD

    srcdir=$src/images/svg
    scalable=hicolor/scalable
    mkdir -p $scalable
    for filename in docker.svg; do
      if [[ $filename != *.svg ]]; then
        continue
      fi
      basename=$(basename -s .svg $filename)
      echo "Building $basename..."
      cp $srcdir/$filename $scalable
      for height in 32 64 128; do
        outdir=hicolor/"$height"x"$height"/apps
        mkdir -p $outdir
        inkscape --export-background-opacity=0 \
          --export-type=png \
          --export-height=$height \
          -o $outdir/$basename.png \
          $srcdir/$filename
      done
    done
  '';

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r hicolor $out/share/icons
  '';

}
