{ pkgs, ... }:
{
  home.packages = with pkgs; [
    drawio
    libreoffice
  ];
}
