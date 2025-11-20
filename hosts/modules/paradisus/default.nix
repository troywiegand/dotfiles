{ pkgs, config, ... }: 

let
  ports = {
    CraftyUI = 8443;
    MC       = 26969;
    VC       = 26970;
    TestMC   = 27069;
    TestVC   = 27070;
  };
  craftyBaseDir = "/mnt/thrull/crafty";
  userName      = "mc";
in
{

  imports = [
    ## Crafty Definition

    ### Docker for Crafty 
    ( import ./crafty.nix {inherit ports; inherit craftyBaseDir; inherit userName;} )
    ## Port Management through variables (firewall and bore)
    ( import ./networking.nix {inherit ports;} )
  ];

# TO-DO's

### Crafty User maangement

### Server Management Declaritive?? This might be easier as a README for initial rollout 

## Borg Backup Jobs


}
