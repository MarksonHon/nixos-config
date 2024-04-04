{ config, pkgs, ... }:

{
  home-manager.useUserPackages = true;
  users.users.markson = {
    isNormalUser = true;
    description = "Markson Hon";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [ chromium ];
  };
  home-manager.users.markson = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userName = "Markson Hon";
      userEmail = "markson@nixos.local";
    };
    programs.zsh = {
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
    home.stateVersion = "24.05";
  };
}
