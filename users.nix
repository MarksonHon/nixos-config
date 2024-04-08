{ config, pkgs, ... }:

{
  home-manager.useUserPackages = true;
  users.users.markson = {
    isNormalUser = true;
    description = "Markson Hon";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "i2c" ];
  };
  home-manager.users.markson = { pkgs, ... }: {
    programs = {
      git = {
        enable = true;
        userName = "Markson Hon";
        userEmail = "markson@nixos.local";
      };
      bash = {
        enable = true;
        initExtra = ''
          # Flatpak Fonts Hook
          for flatpak_app in ~/.var/app/*; do
            [ -d "$flatpak_app/fontconfig" ] || mkdir -p "$flatpak_app/fontconfig"
            cat /etc/fonts/local.conf > "$flatpak_app/fontconfig/fonts.conf"
          done
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
