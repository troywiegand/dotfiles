{ port, boreName, config, ... }:
let
  serviceName = "bore-${boreName}";
  boreSecret = config.sops.secrets."boreSecret".path;
  boreServerTarget = config.sops.secrets."boreServerTarget".path;
in
{
  ## Create a bore secret and populate it
  sops.secrets."boreSecret" = {};
  sops.secrets."boreServerTarget" = {};

  virtualisation.oci-containers = {
    backend = "podman";
    containers."${serviceName}" = {
      image       = "ekzhang/bore";
      autoStart   = true;
      ## Include this once secret is enabled
      environmentFiles = [
        boreSecret
        boreServerTarget
      ];
      cmd = [ "local" "--port" "${builtins.toString port}" "${builtins.toString port}" ];
      extraOptions = [ 
        "--network" "host"
      ];
    };
  };

}
