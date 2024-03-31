{ config, pkgs, ... }:

{
  home-manager.useUserPackages = true;
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
        promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        syntaxHighlighting = {
          enable = true;
          styles = { "alias" = "fg=magenta,bold"; };
        };
      };
      home.stateVersion = "24.05";

    };

}
