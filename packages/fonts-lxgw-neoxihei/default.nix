{ fetchurl, fetchFromGitHub, stdenv, fontconfig }:

stdenv.mkDerivation rec {
    name = "lxgw-neoxihei-fonts-${version}";
    pname = "lxgw-neoxihei-fonts";
    version = "v1.123.2";

    src = fetchurl {
        url = "https://github.com/lxgw/LxgwNeoXiHei/releases/download/v1.123.2/LXGWNeoXiHei.ttf";
        sha256 = "b285453dea14e11a2f938c695ddf740a3cd0d72d6bc75393ff878a0993537784";
    };
    unpackPhase = ''
        cat $src > LXGWNeoXiHei.ttf
    '';
    installPhase = ''
        mkdir -p $out/share/fonts/lxgw-neoxihei-fonts
        cp LXGWNeoXiHei.ttf $out/share/fonts/lxgw-neoxihei-fonts/LXGWNeoXiHei.ttf
    '';
}