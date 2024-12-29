{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # video editing
    losslesscut-bin

    # video recording
    obs-studio
  ];
}
