{ config, pkgs, ... }:
let
  mountPoint = "/mnt/thrull/paperless";
  paperlessPort = 8000;
in {
  # create network in systemd
  systemd.services.init-paperless-network = {
    description = "Create network for paperless containers.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.type = "oneshot";
    script = let
      containercli = "${config.virtualisation.podman.package}/bin/podman";
    in ''
      check=$(${containercli} network ls | grep "paperless" || true)
      if [ -z "$check" ]; then
        ${containercli} network create paperless
      else
        echo "Network 'paperless' already exists."
      fi

      if [ -d "${mountPoint}/media" ]; then
        echo "Paperless Directory Exists"
      else
        mkdir "${mountPoint}"
        mkdir "${mountPoint}/data"
        mkdir "${mountPoint}/media"
        mkdir "${mountPoint}/export"
        mkdir "${mountPoint}/consume"
      fi
    '';
  };
  
  networking.firewall.allowedTCPPorts = [ paperlessPort ];

  # the containers
  virtualisation.oci-containers.containers = {
    paperless = {
      image = "ghcr.io/paperless-ngx/paperless-ngx:2.13";
      ports = [ "${builtins.toString paperlessPort}:8000" ];
      volumes = [
        "${mountPoint}/data:/usr/src/paperless/data"
        "${mountPoint}/media:/usr/src/paperless/media"
        "${mountPoint}/export:/usr/src/paperless/export"
        "${mountPoint}/consume:/usr/src/paperless/consume"
      ];
      environment = {
        PAPERLESS_REDIS = "redis://paperless-redis:6379";
        # removed digital signatures for OCR
        # see the original version of the document for unmodified version
        PAPERLESS_OCR_USER_ARGS = ''{"invalidate_digital_signatures": true}'';
      };
      dependsOn = [ "paperless-redis" ];
      autoStart = true;
      #user = "1000";
      extraOptions = [
        "--network=paperless"
      ];
    };
    paperless-redis = {
      image = "library/redis:latest"; # official docker images use "library/"
      volumes = [ "redisdata:/data" ];
      autoStart = true;
      #user = "1000";
      extraOptions = [
        "--network=paperless"
      ];
    };
  };
}
