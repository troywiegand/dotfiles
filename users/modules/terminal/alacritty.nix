{ pkgs, lib, ... }: let
in {
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      #general.import = [ pkgs.alacritty-theme.catppuccin_mocha ];
      window = {
        opacity = 0.85;
        padding.x = 24;
        padding.y = 24;
      };
      font = {
        normal.family = "Iosevka Nerd Font Mono";
      };
      keyboard.bindings = [
        { 
          key = "I";
          mods = "Alt";
          action = "IncreaseFontSize";
        }
        { 
          key = "U";
          mods = "Alt";
          action = "DecreaseFontSize";
        }
      ];
    };
  };
}
