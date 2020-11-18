{ runCommandNoCC, src, jdk11, makeWrapper, release }:
runCommandNoCC "eclipse-jee"
{
  inherit src;
  version = release;
  buildInputs = [
    makeWrapper
  ];
  propagateBuildInputs = [
    src
    jdk11
  ];
  # prevent caching to save the storage since the distribution size
  # is large
  preferLocalBuild = true;
}
  ''
    mkdir -p $out/bin $out/share/applications

    bin=$out/bin/eclipse-jee
    desktopFile=$out/share/applications/eclipse-jee.desktop

    makeWrapper $src/eclipse $bin \
      --add-flags "-vm ${jdk11}/bin/java"

    cp ${./eclipse-jee.desktop} $desktopFile
    substituteInPlace $desktopFile \
      --replace TryExec=eclipse TryExec=$src/eclipse \
      --replace Exec=eclipse-jee Exec=$bin \
      --replace icon.xpm $src/icon.xpm
  ''
