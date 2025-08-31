{ ... }:
{
  virtualisation.oci-containers = {
    containers = {
      jellyfin = {
        image = "linuxserver/jellyfin:10.10.3";
        ports = [ "8096:8096" ];
        autoStart = true;
        volumes = [ 
          "/mnt/barracuda/media:/media" 
          "jellyfin_config:/config"
        ];
      };
    };
  };
}
