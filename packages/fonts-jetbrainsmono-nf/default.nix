{ fetchurl, stdenv, fontconfig, unzip, ... }:

stdenv.mkDerivation rec {
  name = "fonts-jetbrainsmono-nf";
  version = "3.2.1";
  src = fetchurl {
    url =
      "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/JetBrainsMono.zip";
    sha256 = "6596922aabaf8876bb657c36a47009ac68c388662db45d4ac05c2536c2f07ade";
  };
  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
    unzip JetBrainsMono.zip
  '';
  installPhase = ''
    mkdir -p $out/share/fonts/fonts-jetbrainsmono-nf
    cp -r * $out/share/fonts/fonts-jetbrainsmono-nf
  '';
}
