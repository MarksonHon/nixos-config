{ config, pkgs, ... }:

{
  home-manager = { useUserPackages = true; };
  users.users.markson = {
    isNormalUser = true;
    description = "Markson Hon";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "i2c" ];
    packages = with pkgs; [ gh flameshot nixfmt htop btop epiphany ];
  };
  home-manager.users.markson = { pkgs, ... }: {
    programs = {
      librewolf = { enable = true; };
      mpv = {
        enable = true;
        scripts = [ pkgs.mpvScripts.uosc ];
        config = {
          vo = "gpu-next";
          hwdec = "auto-safe";
          gpu-api = "vulkan";
          gpu-context = "waylandvk";
        };
        bindings = { "r" = "cycle_values video-rotate 90 180 270 0"; };
      };
      yt-dlp = { enable = true; };
      nheko.enable = true;
      bash = {
        enable = true;
        initExtra = ''
          # Flatpak Fonts Hook
          for flatpak_app in ~/.var/app/*; do
            [ -d "$flatpak_app/config/fontconfig" ] || mkdir -p "$flatpak_app/config/fontconfig"
            cat /etc/fonts/local.conf > "$flatpak_app/config/fontconfig/fonts.conf"
          done
          # Set QT_AUTO_SCREEN_SCALE_FACTOR
          unset QT_AUTO_SCREEN_SCALE_FACTOR
          export QT_AUTO_SCREEN_SCALE_FACTOR=1
        '';
      };
      zsh = {
        enable = true;
        autocd = true;
        initExtra = ''
          POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
          source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          if [ -f ~/.p10k.zsh ]; then
            source ~/.p10k.zsh
          else
            p10k configure
          fi
        '';
        completionInit = ''
          autoload -Uz compinit
          compinit
          zstyle ':completion:*' menu select
        '';
        historySubstringSearch = {
          enable = true;
          searchUpKey = "^[A";
          searchDownKey = "^[B";
        };
        autosuggestion = {
          enable = true;
          highlight = "fg=#ff00ff,bg=cyan,bold,underline";
        };
        syntaxHighlighting = {
          enable = true;
          highlighters = [ "main" "brackets" ];
          styles = {
            main = "fg=white";
            brackets = "fg=red";
          };
        };
        shellAliases = {
          ll = "ls -l";
          la = "ls -la";
          df = "df -h";
          ip = "ip -c";
          grep = "grep --color=auto";
          fgrep = "fgrep --color=auto";
          egrep = "egrep --color=auto";
        };
      };
      chromium = {
        enable = true;
        commandLineArgs = [
          "--ozone-platform-hit=auto"
          "--enable-wayland-ime"
          "--enable-features=VaapiVideoDecoderLinuxGL"
        ];
      };
    };
    home.stateVersion = "24.05";
  };
}
