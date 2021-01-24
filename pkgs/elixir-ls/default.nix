{ callPackage, elixir }:
let
  version = "0.6.2";
in
{
  elixir-ls_1_8 = callPackage ./server.nix {
    inherit version;
    inherit elixir;
    elixir-version = "1.8.2";
    sha256 = "0sss10pzs90g7wgbk38k5jhmg1a0xk28xjkpb9992q3j3awlx3v0";
  };
  elixir-ls_1_9 = callPackage ./server.nix {
    inherit version;
    inherit elixir;

    elixir-version = "1.9";
    sha256 = "1g2f5a7bw4a53xfj1i45ljbxgl2cnl0kklxc9vv8xhdj6pyl47ra";
  };
  elixir-ls_1_10 = callPackage ./server.nix {
    inherit version;
    inherit elixir;
    elixir-version = "1.10.4";
    sha256 = "18r46p5997zq9p7mdriwnv1y05a7l1bzwavc16q214gp4mkpqa0h";
  };
  elixir-ls_1_11 = callPackage ./server.nix {
    inherit version;
    inherit elixir;
    elixir-version = "1.11";
    sha256 = "027m6f812nf8ibw901lf449gfxifiplpsajzglmpxmh6h2pj3jqw";
  };
}
