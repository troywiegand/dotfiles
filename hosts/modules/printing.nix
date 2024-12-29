{ config, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Printing

  environment.systemPackages = with pkgs; [
    hplip
  ];

  # ????
  # TODO: figure out what here is actually necessary
  # this whole thing is a mess
  # printing
  services.printing.enable = true; # enables printing support via the CUPS daemon
  services.avahi.enable = true; # runs the Avahi daemon
  services.avahi.nssmdns4 = true; # enables the mDNS NSS plug-in
  services.avahi.openFirewall = true; # opens the firewall for UDP port 5353

  #services.avahi = {
  #  enabled = true;
  #  nssmdns = true;
  #  openFirewall = true;
  #};
}
