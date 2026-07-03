{ ports, craftyBaseDir, userName, ... }:
{

  systemd.tmpfiles.rules = [
  "d ${craftyBaseDir}/ 0755 ${userName} ${userName} -"
  "d ${craftyBaseDir}/backups 0755 ${userName} ${userName} -"
  "d ${craftyBaseDir}/logs 0755 ${userName} ${userName} -"
  "d ${craftyBaseDir}/servers 0755 ${userName} ${userName} -"
  "d ${craftyBaseDir}/config 0755 ${userName} ${userName} -"
  "d ${craftyBaseDir}/import 0755 ${userName} ${userName} -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.paradisus-crafty = {
      image       = "registry.gitlab.com/crafty-controller/crafty-4:4.10.4";
      autoStart   = true;
      ports       = [
        "${builtins.toString ports.CraftyUI}:8443"
        "${builtins.toString ports.Prometheus}:${builtins.toString ports.Prometheus}"
        "${builtins.toString ports.MC}:${builtins.toString ports.MC}"
        "${builtins.toString ports.VC}:${builtins.toString ports.VC}/udp"
        "${builtins.toString ports.TestMC}:${builtins.toString ports.TestMC}"
        "${builtins.toString ports.TestVC}:${builtins.toString ports.TestVC}/udp"
      ];
      volumes     = [
        "${craftyBaseDir}/backups:/crafty/backups"
        "${craftyBaseDir}/logs:/crafty/logs"
        "${craftyBaseDir}/servers:/crafty/servers"
        "${craftyBaseDir}/config:/crafty/app/config"
        "${craftyBaseDir}/import:/crafty/import"
      ];
      environment = {
        TZ = "Etc/UTC";
      };
    };
  };
}
