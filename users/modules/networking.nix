{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dig
    dnsutils
  ];
}
