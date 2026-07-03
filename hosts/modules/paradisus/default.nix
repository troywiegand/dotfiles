{ pkgs, config, ... }: 

let
  ports = {
    CraftyUI   = 27765;
    MC         = 26869;
    VC         = 26870;
    Prometheus = 25585;
    Grafana    = 3333;
    TestMC     = 27069;
    TestVC     = 27070;
  };
  craftyBaseDir       = "/mnt/thrull/crafty";
  paradisusBackupUUID = "e17cfc0b-ca9f-42fa-89ef-d9adbb052694";
  paradisusBackupDir  = "${craftyBaseDir}/backups/${paradisusBackupUUID}";
  userName            = "root";
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
    ## Used for testing commands
    pkgs.bore-cli
  ];

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 */3 * *      troy     find ${paradisusBackupDir} -name '*.zip' -mtime -3 | xargs -I {} scp {} dante@purgator:/srv/backups/"
      "0 0 */3 * *      troy     find ${paradisusBackupDir} -name '*.zip' -mtime -3 | xargs -I {} gcloud storage cp {} gs://paradisus-backups/"
    ];
  };

}
