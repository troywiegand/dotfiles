{
  pkgs,
  config,
  ...
}: let
  vpnNamespace = "wg";

  # Only qBittorrent is VPN-confined — it carries the actual torrent traffic.
  # Prowlarr, Sonarr, and FlareSolverr run on the host network so that
  # FlareSolverr can solve Cloudflare challenges from a real IP, and cookies
  # remain valid for subsequent Prowlarr/Sonarr requests from the same IP.
  vpnServices = {
    qbittorrent.webuiPort = 9009;
  };

  hostServices = {
    prowlarr.webuiPort = 9696;
    sonarr.webuiPort = 8989;
    flaresolverr.webuiPort = 8191;
  };

  vpnServiceNames = builtins.attrNames vpnServices;
  vpnPortList = builtins.map (name: vpnServices.${name}.webuiPort) vpnServiceNames;
in {
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    webuiPort = vpnServices.qbittorrent.webuiPort;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.flaresolverr = {
    enable = true;
    openFirewall = true;
    port = hostServices.flaresolverr.webuiPort;
  };

}
