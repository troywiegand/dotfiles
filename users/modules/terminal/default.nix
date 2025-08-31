{ pkgs, inputs, ... }:
{
  imports = [
    ./urxvt.nix
  ];

  home.packages = with pkgs; [
        fonts = [
            pkgs.nerd-fonts.Iosevka
            pkgs.nerd-fonts.IosevkaTerm
            #"IosevkaTermSlab" ??
        ];
    noto-fonts-emoji
    #iosevka-bin
  ];
}
