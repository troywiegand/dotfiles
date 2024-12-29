{ config, pkgs, ... }:
{
  systemd.services.init-rustdesk-network = {
    description = "Create network for rustdesk containers.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.type = "oneshot";
    script = let
      dockercli = "${config.virtualisation.docker.package}/bin/docker";
    in ''
      check=$(${dockercli} network ls | grep "rustdesk" || true)
      if [ -z "$check" ]; then
        ${dockercli} network create rustdesk
      else
        echo "Network 'rustdesk' already exists."
      fi
    '';
  };

  virtualisation.oci-containers.containers = {
    rustdesk-hbbs = {
      image = "rustdesk/rustdesk-server:latest";
      ports = [ "21115:21115" "21116:21116" "21116:21116/udp" "21118:21118" ];
      dependsOn = [ "rustdesk-hbbr" ];
      entrypoint = "hbbs"; 
      cmd = ["-r" "rustdesk-hbbr:21117"];
      autoStart = true;
      extraOptions = [
        "--network=rustdesk"
      ];
    };
    rustdesk-hbbr = {
      image = "rustdesk/rustdesk-server:latest";
      entrypoint = "hbbr";
      autoStart = true;
      ports = [ "21117:21117" "21119:21119" ];
      extraOptions = [
        "--network=rustdesk"
      ];
    };
  };
}
