{ pkgs, config, ... }:
let
  excalidrawPort = 5000;
in {
  ## TO-DO: Determine Backend File Saving Solution
  virtualisation.oci-containers = {
    backend = "podman";
    containers.excalidraw = {
      image = "excalidraw/excalidraw:latest";
      ports = [
        "${builtins.toString excalidrawPort}:80"
      ];
      autoStart = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ excalidrawPort ];
}
