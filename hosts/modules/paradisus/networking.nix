{ ports, config, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.attrValues ports;

  networking.extraHosts = ''
  45.63.69.240 purgator
  '';

  imports = [
    ## Import Bore for certain ports
    ## Wait until we have the bore target setup on purgator
    ( import ./bore.nix {port = ports.CraftyUI; boreName="CraftyUI"; inherit config;} )
    ( import ./bore.nix {port = ports.Grafana; boreName="Grafana"; inherit config;} )
    ##( import ./bore.nix {port = ports.TestMC; boreName="TestMC"; inherit config;} )
    ##( import ./bore.nix {port = ports.TestVC; boreName="TestVC"; inherit config;} )
  ];



}
