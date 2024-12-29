{ config, pkgs, ... }:
{
  virtualisation = {
    docker = {
      enable = true;
    };
    oci-containers.backend = "docker";
  };
}
