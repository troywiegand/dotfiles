{ config, pkgs, ... }:
{
  # create network in systemd
  systemd.services.init-paperless-network = {
    description = "Create network for paperless containers.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.type = "oneshot";
    script = let
      dockercli = "${config.virtualisation.docker.package}/bin/docker";
    in ''
      check=$(${dockercli} network ls | grep "paperless" || true)
      if [ -z "$check" ]; then
        ${dockercli} network create paperless
      else
        echo "Network 'paperless' already exists."
      fi
    '';
  };

  # the containers
  virtualisation.oci-containers.containers = {
    paperless = {
      image = "ghcr.io/paperless-ngx/paperless-ngx:2.13";
      ports = [ "8000:8000" ];
      volumes = [
        "/mnt/barracuda/paperless/data:/usr/src/paperless/data"
        "/mnt/barracuda/paperless/media:/usr/src/paperless/media"
        "/mnt/barracuda/paperless/export:/usr/src/paperless/export"
        "/mnt/barracuda/paperless/consume:/usr/src/paperless/consume"
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
