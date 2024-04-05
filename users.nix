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
      zsh = {
        enable = true;
        autocd = true;
        completionInit = ''
          autoload -Uz compinit
          compinit
          zstyle ':completion:*' menu select
          autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
          zle -N up-line-or-beginning-search 
          zle -N down-line-or-beginning-search
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
