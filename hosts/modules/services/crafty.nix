{ config, lib, pkgs, ... }:
let
  minecraftUser = "mc";
  craftyBaseDir = "/opt/crafty";
  craftyPort    = 8443;
  dynamapPort   = 8124;
  paradisusTest = {
    Port = 26960;
    VCPort = 26961;
  };
in {
  networking.firewall.allowedTCPPorts = [ craftyPort dynamapPort paradisusTest.Port paradisusTest.VCPort ];

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
    containers.crafty = {
      image       = "arcadiatechnology/crafty-4:4.5.5";
      autoStart   = true;
      ports       = [
        "${builtins.toString craftyPort}:8443"
        "${builtins.toString dynamapPort}:8123"
        "${builtins.toString paradisusTest.Port}:25565"
        "${builtins.toString paradisusTest.VCPort}:${builtins.toString paradisusTest.VCPort}/udp"
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
