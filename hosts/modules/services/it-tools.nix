{ pkgs, config, ... }:
let
  ittoolsPort = 5003;
in {
  virtualisation.oci-containers = {
    backend = "podman";
    containers.ittools = {
      image = "ghcr.io/corentinth/it-tools:latest";
      ports = [
        "${builtins.toString ittoolsPort}:80"
      ];
      autoStart = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ ittoolsPort ];
}
