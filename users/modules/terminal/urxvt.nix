{
  programs.urxvt = {
    enable = true;
    fonts = [ 
      "xft:Iosevka Nerd Font Mono:size=11" # nerdfont
      "xft:DroidSansM Nerd Font Mono:size=10" # nerdfont
      "xfg:Noto Color Emoji" # emoji
      "xft:DejaVu Sans Mono:size=10" # fallback
    ];
    keybindings = {
      "Shift-Control-C" = "eval:selection_to_clipboard";
      "Shift-Control-V" = "eval:paste_clipboard";
      "Control-Equals" = "font-size:increase";
      "Control-Minus" = "font-size:decrease";
    };
    extraConfig = {
      # catppuccin: https://github.com/catppuccin/urxvt/blob/main/catppuccin.Xresources
      foreground = "#DADAE8";
      background = "#1E1E29";
      cursorColor = "#B1E3AD";
      color0 = "#6E6C7E";
      color8 = "#6E6C7E";
      color1 = "#E38C8F";
      color9 = "#E38C8F";
      color2 = "#B1E3AD";
      color10 = "#B1E3AD";
      color3 = "#EBDDAA";
      color11 = "#EBDDAA";
      color4 = "#A4B9EF";
      color12 = "#A4B9EF";
      color5 = "#C6AAE8";
      color13 = "#C6AAE8";
      color6 = "#E5B4E2";
      color14 = "#E5B4E2";
      color7 = "#DADAE8";
      color15 = "#DADAE8";
      letterSpace = 0;
      lineSpace = 0;
      geometry = "92x24";
      internalBorder = 24;
      cursorBlink = true;
      cursorUnderline = false;
      saveline = 2048;
      scrollBar = false;
      scrollBar_right = false;
      urgentOnBell = true;
      depth = 24;
      iso14755 = false;
    };
  };
}
