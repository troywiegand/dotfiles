{ pkgs, config, ... }:
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers.home-assistant = {
      image = "ghcr.io/home-assistant/home-assistant:2025.8";
      volumes = [
        "/mnt/thrull/home-assistant/config:/config"
        "/etc/localtime:/etc/localtime:ro"
        "/run/dbus:/run/dbus:ro"
      ];
      autoStart = true;
      extraOptions = [ 
        # Use the host network namespace for all sockets
        "--network=host"
      ];
    };
  };
}
