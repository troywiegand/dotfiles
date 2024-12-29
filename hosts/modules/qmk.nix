{ pkgs, ... }:
{
  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = [ pkgs.via pkgs.qmk ];
  services.udev.packages = [ pkgs.via ];
}
