{ config, pkgs, ... }:

{
  home-manager = {
    useUserPackages = true;
  };
  users.users.markson = {
    isNormalUser = true;
    description = "Markson Hon";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "i2c" ];
    packages = with pkgs; [
      gh
      flameshot
      nixfmt
      htop
      btop
    ];
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
          gpu-context="waylandvk";
        };
        bindings= {
          "r" = "cycle_values video-rotate 90 180 270 0";
        };
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
        completionInit = ''
          autoload -Uz compinit
          compinit
          zstyle ':completion:*' menu select
        '';
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
