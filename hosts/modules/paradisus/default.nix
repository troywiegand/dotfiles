{ pkgs, config, ... }: 

let
  ports = {
    CraftyUI = 8443;
    MC       = {
      MC       = 26969;
      VC       = 26970;
      TestMC   = 27069;
      TestVC   = 27070;
    }
  };

  craftyBaseDir = "/mnt/thrull/crafty";
  userName      = "mc";
in
{


## Crafty Definition

### Docker for Crafty 
crafty = import ./crafty.nix {inherit ports; inherit craftyBaseDir; inherit userName;};

### Crafty User maangement

### Server Management Declaritive?? This might be easier as a README for initial rollout 

## Port Management through variables (firewall and bore)

networking = import ./networking.nix {inherit ports;};

## Borg Backup Jobs


}
