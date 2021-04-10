{ src
, stdenv
, version
, ruby
, cmake
, # pkg-config,
  # zlib,
  # icu,
  # libcurl,
  # openssl,


}:
stdenv.mkDerivation {
  name = "linguist";
  inherit src version;

  buildPhase = ''
  '';
}
