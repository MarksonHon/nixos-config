{ config, pkgs, ... }:

{
  users.users.markson = {
    isNormalUser = true;
    description = "Markson Hon";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [ chromium ];
  };
  home-manager.users.markson = { pkgs, ... }:

    {
      programs.git = {
        enable = true;
        userName = "Markson Hon";
        userEmail = "markson@nixos.local";
      };
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
        promptInit = "promptinit";
        theme = "agnoster";
      };
    }

    { home.stateVersion = "24.05"; };
}
