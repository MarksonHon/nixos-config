{ fetchurl, fetchFromGitHub, stdenv, fontconfig }:

stdenv.mkDerivation rec {
    name = "lxgw-neoxihei-fonts-${version}";
    pname = "lxgw-neoxihei-fonts";
    version = "v1.120.2";

    src = fetchurl {
        url = "https://github.com/lxgw/LxgwNeoXiHei/releases/download/v1.120.2/LXGWNeoXiHei.ttf";
        sha256 = "44dd0e98d4b769244c2b5f67362a97609e0f200421eaee56ffe2fc0c27aa31c1";
    };
    unpackPhase = ''
        cat $src > LXGWNeoXiHei.ttf
    '';
    installPhase = ''
        mkdir -p $out/share/fonts/lxgw-neoxihei-fonts
        cp LXGWNeoXiHei.ttf $out/share/fonts/lxgw-neoxihei-fonts/LXGWNeoXiHei.ttf
    '';
}