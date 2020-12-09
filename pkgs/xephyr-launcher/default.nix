{ runCommandNoCC, makeWrapper, xorgserver, xdpyinfo }:
runCommandNoCC "xephyr-launcher"
{
  buildInputs = [
    makeWrapper
  ];
}
  ''
    mkdir -p $out/bin
    cp ${./xephyr-launcher.sh} $out/bin/xephyr-launcher
    chmod +x $out/bin/xephyr-launcher
    wrapProgram $out/bin/xephyr-launcher \
      --prefix PATH : ${xorgserver}/bin \
      --prefix PATH : ${xdpyinfo}/bin
  ''
