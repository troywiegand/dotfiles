{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qjoypad
    jstest-gtk
  ];
}
