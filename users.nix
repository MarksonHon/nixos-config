{ config, pkgs, ... }:

{
  home-manager = { useUserPackages = true; };
  users.users.markson = {
    isNormalUser = true;
    description = "Markson Hon";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "i2c" ];
    packages = with pkgs; [ gh flameshot nixfmt htop btop zsh-syntax-highlighting zsh-powerlevel10k ];
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
          # create a zkbd compatible hash;
          # to add other keys to this hash, see: man 5 terminfo
          typeset -g -A key
          key[Home]="''${terminfo[khome]}"
          key[End]="''${terminfo[kend]}"
          key[Insert]="''${terminfo[kich1]}"
          key[Backspace]="''${terminfo[kbs]}"
          key[Delete]="''${terminfo[kdch1]}"
          key[Up]="''${terminfo[kcuu1]}"
          key[Down]="''${terminfo[kcud1]}"
          key[Left]="''${terminfo[kcub1]}"
          key[Right]="''${terminfo[kcuf1]}"
          key[PageUp]="''${terminfo[kpp]}"
          key[PageDown]="''${terminfo[knp]}"
          key[Shift-Tab]="''${terminfo[kcbt]}"
          # setup key accordingly
          [[ -n "''${key[Home]}"      ]] && bindkey -- "''${key[Home]}"       beginning-of-line
          [[ -n "''${key[End]}"       ]] && bindkey -- "''${key[End]}"        end-of-line
          [[ -n "''${key[Insert]}"    ]] && bindkey -- "''${key[Insert]}"     overwrite-mode
          [[ -n "''${key[Backspace]}" ]] && bindkey -- "''${key[Backspace]}"  backward-delete-char
          [[ -n "''${key[Delete]}"    ]] && bindkey -- "''${key[Delete]}"     delete-char
          [[ -n "''${key[Up]}"        ]] && bindkey -- "''${key[Up]}"   up-line-or-beginning-search
          [[ -n "''${key[Down]}"      ]] && bindkey -- "''${key[Down]}" down-line-or-beginning-search
          [[ -n "''${key[Left]}"      ]] && bindkey -- "''${key[Left]}"       backward-char
          [[ -n "''${key[Right]}"     ]] && bindkey -- "''${key[Right]}"      forward-char
          [[ -n "''${key[PageUp]}"    ]] && bindkey -- "''${key[PageUp]}"     beginning-of-buffer-or-history
          [[ -n "''${key[PageDown]}"  ]] && bindkey -- "''${key[PageDown]}"   end-of-buffer-or-history
          [[ -n "''${key[Shift-Tab]}" ]] && bindkey -- "''${key[Shift-Tab]}"  reverse-menu-complete
          # Finally, make sure the terminal is in application mode, when zle is
          # active. Only then are the values from ''$terminfo valid.
          if (( ''${+terminfo[smkx]} && ''${+terminfo[rmkx]} )); then
                  autoload -Uz add-zle-hook-widget
                  function zle_application_mode_start { echoti smkx }
                  function zle_application_mode_stop { echoti rmkx }
                  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
                  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
          fi
          autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
          zle -N up-line-or-beginning-search
          zle -N down-line-or-beginning-search
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
