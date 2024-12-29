{ pkgs, config, ... }: let
  network-name = "tube-archivist";
in {
  systemd.services.init-tube-archivist-network = {
    description = "Create network for ${network-name} containers.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.type = "oneshot";
    script = let
      dockercli = "${config.virtualisation.docker.package}/bin/docker";
    in ''
      check=$(${dockercli} network ls | grep "${network-name}" || true)
      if [ -z "$check" ]; then
        ${dockercli} network create ${network-name}
      else
        echo "Network '${network-name}' already exists."
      fi
    '';
  };
  virtualisation.oci-containers.containers = {
    tube-archivist = {
      image = "bbilly1/tubearchivist:v0.4.11";
      ports = [ "8090:8000" ];
      volumes = [
        "tube-archivist-cache:/cache"
        "tube-archivist-media:/youtube"
      ];
      environment = {
        ES_URL = "http://tube-archivist-elastic-search:9200";
        REDIS_HOST = "tube-archivist-redis";
        TA_HOST = "192.168.50.3";
        HOST_UID = "1000";
        HOST_GID = "1000";
        TA_USERNAME = "admin";
        TA_PASSWORD = "admin";
        ELASTIC_PASSWORD = "admin";
        TZ = "America/Chicago";
      };
      dependsOn = [ "tube-archivist-redis" "tube-archivist-elastic-search" ];
      autoStart = true;
      extraOptions = [
        "--network=${network-name}"
      ];
    };
    tube-archivist-redis = {
      image = "redis/redis-stack-server";
      autoStart = true;
      dependsOn = [ "tube-archivist-elastic-search" ];
      volumes = [
        "tube-archivist-redis:/data"
      ];
      extraOptions = [
        "--network=${network-name}"
      ];
    };
    tube-archivist-elastic-search = {
      image = "library/elasticsearch:8.14.3";
      autoStart = true;
      ports = [ "9200:9200" ];
      volumes = [
        "tube-archivist-elastic-search:/usr/share/elasticsearch/data"
      ];
      environment = {
        ELASTIC_PASSWORD = "admin";
        ES_JAVA_OPTS = "-Xms1g -Xmx1g";
        "xpack.security.enabled" = "true";
        "discovery.type" = "single-node";
        "path.repo" = "/usr/share/elasticsearch/data/snapshot";
      };
      extraOptions = [
        "--network=${network-name}"
      ];
    };
  };
  
}
