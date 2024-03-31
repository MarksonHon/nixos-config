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
      ohMyZshModule = {
        enable = true;
        plugins = [ "git" "sudo" "command-not-found" ];
      };
      syntaxHighlightingModule = {
        enable = true;
        packages = with pkgs; [ zsh-syntax-highlighting ];
        highlighters = [ "main" "brackets" "pattern" ];
    };
    home.stateVersion = "24.05";
  };

}
