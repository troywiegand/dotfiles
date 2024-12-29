{ config, pkgs, ... }: let
  pg_user = "freshrss";
  pg_db = "freshrss";
  pg_pass = "secret_freshrss_password";
in {
  # create network in systemd
  systemd.services.init-freshrss-network = {
    description = "Create network for freshrss containers.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.type = "oneshot";
    script = let
      dockercli = "${config.virtualisation.docker.package}/bin/docker";
    in ''
      check=$(${dockercli} network ls | grep "freshrss" || true)
      if [ -z "$check" ]; then
        ${dockercli} network create freshrss
      else
        echo "Network 'freshrss' already exists."
      fi
    '';
  };

  # the containers
  virtualisation.oci-containers.containers = {
    freshrss = {
      image = "freshrss/freshrss:1.24.1";
      ports = [ "8084:80" ];
      volumes = [
        "/mnt/barracuda/freshrss/data:/var/www/FreshRSS/data"
        "/mnt/barracuda/freshrss/extensions:/var/www/FreshRSS/extensions"
      ];
      environment = {};
      dependsOn = [ "freshrss-db" ];
      autoStart = true;
      environment = {
        TZ = "US/Indiana/Indianapolis";
        DB_HOST = "freshrss-db";
        DB_PASSWORD = pg_pass;
        DB_BASE = pg_db;
        DB_USER = pg_user;
        ADMIN_EMAIL = "dave@rutrum.net";
        ADMIN_PASSWORD = "freshrss";
        ADMIN_API_PASSWORD = "freshrss";
      };
      extraOptions = [
        "--network=freshrss"
      ];
    };
    freshrss-db = {
      image = "library/postgres:latest"; # official docker images use "library/"
      volumes = [ "/mnt/barracuda/freshrss/db:/var/lib/postgres/data" ];
      autoStart = true;
      environment = {
        POSTGRES_USER = pg_user;
        POSTGRES_PASSWORD = pg_pass;
        POSTGRES_DB = pg_db;
      };
      extraOptions = [
        "--network=freshrss"
      ];
    };
  };
}
