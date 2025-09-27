{ config, lib, pkgs, ... }:
let
  minecraftUser     = "mc";
  minecraftBaseDir  = "/opt/mc";
  reclaimPort       = 25587;
  paradisusTest= {
    Port = 26969;
    VCPort = 26968;
    SeedPath = config.sops.secrets."paradisusTest/seed".path;
    Dir  = "${minecraftBaseDir}/paratest";
  };
in {
  users.users.${minecraftUser} = {
    isSystemUser = true;
    group        = minecraftUser;
    extraGroups  = [ "networkmanager" "podman" "docker" ];
    shell        = pkgs.bash;
    linger       = true;
    home         = minecraftBaseDir;
  };
  users.groups.${minecraftUser} = {};
  networking.firewall.allowedTCPPorts = [ reclaimPort paradisusTest.Port paradisusTest.VCPort ];
  sops.secrets."paradisusTest/seed" = {};
  ## TO-DO: Move the Recalim Container Definition Here

  systemd.tmpfiles.rules = [
  "d ${minecraftBaseDir} 0755 ${minecraftUser} ${minecraftUser} -"
  "d ${minecraftBaseDir}/.config 0755 ${minecraftUser} ${minecraftUser} -"
  "d ${paradisusTest.Dir} 0755 ${minecraftUser} ${minecraftUser} -"
  "d ${paradisusTest.Dir}/data 0755 ${minecraftUser} ${minecraftUser} -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.paratest = {
      image       = "docker.io/itzg/minecraft-server";
      autoStart   = true;
      ports       = [
        "${builtins.toString paradisusTest.Port}:25565"
        "${builtins.toString paradisusTest.VCPort}:${builtins.toString paradisusTest.VCPort}/udp"
      ];
      volumes     = [
        "${paradisusTest.Dir}/data:/data"
      ];
      environmentFiles = [
        paradisusTest.SeedPath
      ];
      environment = {
        EULA                          = "TRUE";
        TYPE                          = "MODRINTH";
        VERSION                       = "1.21.4";
        MEMORY                        = "8G";
        MODRINTH_MODPACK              = "hermitcraft";
        MODRINTH_LOADER               = "fabric";
        MODRINTH_DEFAULT_VERSION_TYPE = "beta";
      };
    };
  };

  ## Run Service as MC user
  /*
  systemd.services."${config.virtualisation.oci-containers.backend}-paratest".serviceConfig = {
      User = lib.mkForce minecraftUser;
      };
  */

}
