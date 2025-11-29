{ pkgs, config, ... }: 

let
  ports = {
    CraftyUI   = 8443;
    MC         = 26869;
    VC         = 26870;
    Prometheus = 25585;
    Grafana    = 3333;
    TestMC     = 27069;
    TestVC     = 27070;
  };
  craftyBaseDir       = "/mnt/thrull/crafty";
  paradisusBackupUUID = "a0a3b705-5937-4df1-9155-5d37ededb34d";
  paradisusBackupDir  = "${craftyBaseDir}/backups/${paradisusBackupUUID}";
  userName            = "mc";
in
{

  imports = [
    ## Crafty Definition

    ### Docker for Crafty 
    ( import ./crafty.nix {inherit ports; inherit craftyBaseDir; inherit userName;} )
    ## Port Management through variables (firewall and bore)
    ( import ./networking.nix {inherit ports; inherit config;} )
    ( import ./prometheus.nix {inherit ports; inherit config;} )
  ];

  environment.systemPackages = [
    pkgs.bore-cli
  ];

# TO-DO's

### Crafty User maangement

### Server Management Declaritive?? This might be easier as a README for initial rollout 

  ## World to Boros
  services.borgbackup.jobs.paradisus-world = {
    paths = paradisusBackupDir;
    encryption.mode = "none";
    environment.BORG_RSH = "ssh -i /home/troy/.ssh/id_ed25519";
    repo = "ssh://troy@boros:/mnt/legion/paradisus";
    compression = "auto,zstd";
    startAt = "daily";
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 * * * *      troy     find ${paradisusBackupDir} -name '*.zip' | xargs -I {} scp {} dante@purgator:/srv/backups/"
      "0 * * * *      troy     find ${paradisusBackupDir} -name '*.zip' | xargs -I {} scp {} troy@boros:/mnt/legion/backups/"
    ];
  };

}
