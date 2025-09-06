{ ... }:
{
  ## Open Jellyfin to other Devices on the Network
  networking.firewall.allowedTCPPorts = [ 8096 ];
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
