{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      roboto
      roboto-serif
      noto-fonts
      dejavu_fonts
      noto-fonts-emoji
      source-han-serif
      lxgw-wenkai
      source-han-sans
      jetbrains-mono
      nerdfonts
      (callPackage ./packages/fonts-harmonyos-sans/default.nix { })
      (callPackage ./packages/fonts-lxgw-neoxihei/default.nix { })
    ];
    fontconfig = {
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
            <!-- Default serif font -->
            <alias binding="strong">
                <family>serif</family>
                <prefer>
                    <family>Noto Serif</family>
                </prefer>
            </alias>

            <!-- Default sans-serif font -->
            <alias binding="strong">
                <family>sans-serif</family>
                <prefer>
                    <family>Noto Sans</family>
                </prefer>
            </alias>

            <!-- Default monospace font -->
            <alias binding="strong">
                <family>monospace</family>
                <prefer>
                    <family>Noto Sans Mono</family>
                </prefer>
            </alias>

            <!-- Default system-ui font -->
            <alias binding="strong">
                <family>system-ui</family>
                <prefer>
                    <family>Noto Sans</family>
                </prefer>
            </alias>

            <!-- Serif CJK -->

            <!-- Default serif when the "lang" attribute is not given -->
            <!-- You can change this font to the language variant you want -->
            <match target="pattern">
                <test name="family">
                    <string>serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Serif SC</string>
                </edit>
            </match>

            <!-- Japanese -->
            <!-- "lang=ja" or "lang=ja-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>ja</string>
                </test>
                <test name="family">
                    <string>serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Serif</string>
                </edit>
            </match>

            <!-- Korean -->
            <!-- "lang=ko" or "lang=ko-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>ko</string>
                </test>
                <test name="family">
                    <string>serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Serif K</string>
                </edit>
            </match>

            <!-- Chinese -->
            <!-- "lang=zh" or "lang=zh-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh</string>
                </test>
                <test name="family">
                    <string>serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Serif SC</string>
                </edit>
            </match>
            <!-- "lang=zh-hans" or "lang=zh-hans-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hans</string>
                </test>
                <test name="family">
                    <string>serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Serif SC</string>
                </edit>
            </match>
            <!-- "lang=zh-hant" or "lang=zh-hant-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hant</string>
                </test>
                <test name="family">
                    <string>serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Serif TC</string>
                </edit>
            </match>
            <!-- Compatible -->
            <!-- "lang=zh-cn" or "lang=zh-cn-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-cn</string>
                </test>
                <test name="family">
                    <string>serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Serif SC</string>
                </edit>
            </match>
            <!-- "lang=zh-tw" or "lang=zh-tw-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-tw</string>
                </test>
                <test name="family">
                    <string>serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Serif TC</string>
                </edit>
            </match>

            <!-- Sans CJK -->

            <!-- Default sans-serif when the "lang" attribute is not given -->
            <!-- You can change this font to the language variant you want -->
            <match target="pattern">
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>

            <!-- Japanese -->
            <!-- "lang=ja" or "lang=ja-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>ja</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans</string>
                </edit>
            </match>

            <!-- Korean -->
            <!-- "lang=ko" or "lang=ko-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>ko</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans K</string>
                </edit>
            </match>

            <!-- Chinese -->
            <!-- "lang=zh" or "lang=zh-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-hans" or "lang=zh-hans-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hans</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-hant" or "lang=zh-hant-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hant</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans TC</string>
                </edit>
            </match>
            <!-- "lang=zh-hant-hk" or "lang=zh-hant-hk-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hant-hk</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans HC</string>
                </edit>
            </match>
            <!-- Compatible -->
            <!-- "lang=zh-cn" or "lang=zh-cn-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-cn</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-tw" or "lang=zh-tw-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-tw</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans TC</string>
                </edit>
            </match>
            <!-- "lang=zh-hk" or "lang=zh-hk-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hk</string>
                </test>
                <test name="family">
                    <string>sans-serif</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans HC</string>
                </edit>
            </match>

            <!-- Mono CJK -->

            <!-- Default monospace when the "lang" attribute is not given -->
            <!-- You can change this font to the language variant you want -->
            <match target="pattern">
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>

            <!-- Japanese -->
            <!-- "lang=ja" or "lang=ja-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>ja</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>Source Han Sans</string>
                </edit>
            </match>

            <!-- Korean -->
            <!-- "lang=ko" or "lang=ko-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>ko</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>Source Han Sans K</string>
                </edit>
            </match>

            <!-- Chinese -->
            <!-- "lang=zh" or "lang=zh-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-hans" or "lang=zh-hans-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hans</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-hant" or "lang=zh-hant-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hant</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>Source Han Sans TC</string>
                </edit>
            </match>
            <!-- "lang=zh-hant-hk" or "lang=zh-hant-hk-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hant-hk</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>Source Han Sans HC</string>
                </edit>
            </match>
            <!-- Compatible -->
            <!-- "lang=zh-cn" or "lang=zh-cn-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-cn</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-tw" or "lang=zh-tw-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-tw</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>Source Han Sans TC</string>
                </edit>
            </match>
            <!-- "lang=zh-hk" or "lang=zh-hk-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hk</string>
                </test>
                <test name="family">
                    <string>monospace</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans Mono</string>
                    <string>Source Han Sans HC</string>
                </edit>
            </match>

            <!-- System UI CJK -->

            <!-- Default system-ui when the "lang" attribute is not given -->
            <!-- You can change this font to the language variant you want -->
            <match target="pattern">
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Noto Sans</string>
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>

            <!-- Japanese -->
            <!-- "lang=ja" or "lang=ja-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>ja</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans</string>
                </edit>
            </match>

            <!-- Korean -->
            <!-- "lang=ko" or "lang=ko-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>ko</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans K</string>
                </edit>
            </match>

            <!-- Chinese -->
            <!-- "lang=zh" or "lang=zh-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-hans" or "lang=zh-hans-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hans</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-hant" or "lang=zh-hant-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hant</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans TC</string>
                </edit>
            </match>
            <!-- "lang=zh-hant-hk" or "lang=zh-hant-hk-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hant-hk</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans HC</string>
                </edit>
            </match>
            <!-- Compatible -->
            <!-- "lang=zh-cn" or "lang=zh-cn-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-cn</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>HarmonyOS Sans SC</string>
                </edit>
            </match>
            <!-- "lang=zh-tw" or "lang=zh-tw-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-tw</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans TC</string>
                </edit>
            </match>
            <!-- "lang=zh-hk" or "lang=zh-hk-*" -->
            <match target="pattern">
                <test name="lang" compare="contains">
                    <string>zh-hk</string>
                </test>
                <test name="family">
                    <string>system-ui</string>
                </test>
                <edit name="family" mode="append" binding="strong">
                    <string>Source Han Sans HC</string>
                </edit>
            </match>
        </fontconfig>
      '';

    };
  };
}
