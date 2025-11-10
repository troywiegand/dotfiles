{ config, lib, pkgs, port, boreName, ... }:
let
  serviceName = "bore-${boreName}"
{
  ## Create a bore secret and populate it
  # sops.secrets."boreSecret" = {};
  # sops.secrets."boreServerTarget" = {};

  virtualisation.oci-containers = {
    backend = "podman";
    containers."${servicename}" = {
      image       = "ekzhang/bore";
      autoStart   = true;
      ports       = [
        "${builtins.toString port}:${builtins.toString port}"
      ];
      ## Include this once secret is enabled
      #environmentFiles = [
      #  paradisusTest.SeedPath
      #];
      extraOptions = [ "--command" "bore local --port ${builtins.toString port}" ];
    };
  };

}
