{ config, lib, pkgs, ports, craftyBaseDir, userName, ... }:
{

  systemd.tmpfiles.rules = [
  "d ${craftyBaseDir} 0755 ${minecraftUser} ${minecraftUser} -"
  "d ${craftyBaseDir}/backups 0755 ${minecraftUser} ${minecraftUser} -"
  "d ${craftyBaseDir}/logs 0755 ${minecraftUser} ${minecraftUser} -"
  "d ${craftyBaseDir}/servers 0755 ${minecraftUser} ${minecraftUser} -"
  "d ${craftyBaseDir}/config 0755 ${minecraftUser} ${minecraftUser} -"
  "d ${craftyBaseDir}/import 0755 ${minecraftUser} ${minecraftUser} -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.paradisus-crafty = {
      image       = "arcadiatechnology/crafty-4:4.5.5";
      autoStart   = true;
      ports       = [
        "${builtins.toString ports.CraftyUI}:8443"
        "${builtins.toString ports.MC}:${builtins.toString ports.MC}"
        "${builtins.toString ports.VC}:${builtins.toString ports.VC}/udp"
        "${builtins.toString ports.TestMC}:${builtins.toString ports.TestMC}"
        "${builtins.toString ports.TestVC}:${builtins.toString ports.TestVC}/udp"
      ];
      volumes     = [
        "${craftyBaseDir}/backups:/crafty/backups"
        "${craftyBaseDir}/logs:/crafty/logs"
        "${craftyBaseDir}/servers:/crafty/servers"
        "${craftyBaseDir}/config:/crafty/config"
        "${craftyBaseDir}/import:/crafty/import"
      ];
      environment = {
        TZ = "Etc/UTC";
      };
    };
  };
}
