{ pkgs, inputs, ... }:
{
  imports = [
    ./urxvt.nix
  ];

  home.packages = with pkgs; [
    (nerdfonts.override {
        fonts = [
            "Iosevka"
            "IosevkaTerm"
            #"IosevkaTermSlab" ??
        ];
    })
    noto-fonts-emoji
    #iosevka-bin
  ];
}
