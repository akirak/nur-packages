{ runCommandNoCC
, src
, makeWrapper
, ffmpeg
, yad
, slop
, gifsicle
, xprop
, xwininfo
}:
runCommandNoCC "bashcaster"
{
  inherit src;
  buildInputs = [ makeWrapper ];
  propagateBuildInputs = [
    ffmpeg
    yad
    slop
    gifsicle
    xprop
    xwininfo
  ];
}
  ''
    mkdir -p $out/bin
    install $src/bashcaster.sh $out/bin/bashcaster
    wrapProgram $out/bin/bashcaster
  ''
