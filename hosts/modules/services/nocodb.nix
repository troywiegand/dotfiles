{ config, pkgs, ... }:
{
  # create network in systemd
  systemd.services.init-nocodb-network = {
    description = "Create network for nocodb containers.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.type = "oneshot";
    script = let
      dockercli = "${config.virtualisation.docker.package}/bin/docker";
    in ''
      check=$(${dockercli} network ls | grep "nocodb" || true)
      if [ -z "$check" ]; then
        ${dockercli} network create nocodb
      else
        echo "Network 'nocodb' already exists."
      fi
    '';
  };

  # the containers
  virtualisation.oci-containers.containers = {
    nocodb = {
      image = "nocodb/nocodb:0.258.3";
      ports = [ "8081:8080" ];
      volumes = [
        "/mnt/barracuda/nocodb/data:/usr/app/data"
      ];
      environment = {
        NC_DB = "pg://nocodb-db:5432?u=postgres&p=password&d=root_db";
      };
      dependsOn = [ "nocodb-db" ];
      autoStart = true;
      extraOptions = [
        "--network=nocodb"
      ];
    };
    nocodb-db = {
      image = "library/postgres:latest"; # official docker images use "library/"
      volumes = [ "/mnt/barracuda/nocodb/db:/var/lib/postgresql/data" ];
      ports = [ "5432:5432" ];
      autoStart = true;
      environment = {
        POSTGRES_DB = "root_db";
        POSTGRES_USER = "postgres";
        POSTGRES_PASSWORD = "password";
      };
      extraOptions = [
        "--network=nocodb"
      ];
    };
  };
}
