{ fetchurl, stdenv, fetchFromGitHub, fontconfig, unzip, ... }:

stdenv.mkDerivation rec {
  name = "fonts-harmonyos-sans";
  pname = "fonts-harmonyos-sans";
  version = "2022.7.4";
  src = fetchurl {
    url =
      "https://developer.huawei.com/images/download/general/HarmonyOS-Sans.zip";
    sha256 = "fb02c86e358cd9aad8d4dfa957ee502381e7ee2e94499a9133add4324b6ce69a";
  };
  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
    unzip $src
    rm -rf __MACOSX
  '';
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r * $out/share/fonts
  '';
}
