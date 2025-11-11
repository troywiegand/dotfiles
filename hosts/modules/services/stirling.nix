{ pkgs, config, ... }:
let
  stirlingPort = 5002;
in {
  ## TO-DO: Look into all the volumes mentioned in the docs.
  ## https://docs.stirlingpdf.com/Installation/Docker%20Install/
  virtualisation.oci-containers = {
    backend = "podman";
    containers.stirling = {
      image = "docker.stirlingpdf.com/stirlingtools/stirling-pdf";
      ports = [
        "${builtins.toString stirlingPort}:8080"
      ];
      autoStart = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ stirlingPort ];
}
