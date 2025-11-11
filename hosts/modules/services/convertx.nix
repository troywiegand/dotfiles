{ pkgs, config, ... }:
let
  excalidrawPort = 5001;
in {
  ## TO-DO: Determine Backend File Saving Solution
  virtualisation.oci-containers = {
    backend = "podman";
    containers.convertx = {
      image = "ghcr.io/c4illin/convertx";
      ports = [
        "${builtins.toString excalidrawPort}:3000"
      ];
      autoStart = true;
      environment = {
        HTTP_ALLOWED = "true";
        ALLOW_UNAUTHENTICATED = "true";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ excalidrawPort ];
}
