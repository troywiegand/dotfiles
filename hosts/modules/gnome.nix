{ config, pkgs, ... }:
{
  services.xserver.desktopManager.gnome.enable = true;

  # Electron and Chromium with Wayland
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = (with pkgs; [
    gnome-tweaks
  ]) ++ (with pkgs.gnomeExtensions; [
    forge
    sound-output-device-chooser
  ]);
}
