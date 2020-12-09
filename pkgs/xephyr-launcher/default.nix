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
      --add PATH : ${xorgserver}/bin \
      --add PATH : ${xdpyinfo}/bin
  ''
