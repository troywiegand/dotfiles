{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    superTuxKart
    prismlauncher
    archipelago
    mindustry
    xonotic
    airshipper # game launcher for veloren
  ];
  services.flatpak.packages = [
    "flathub:app/info.beyondallreason.bar//stable"
  ];
}
