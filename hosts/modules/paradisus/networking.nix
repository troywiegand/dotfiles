{ ports, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.attrValues ports;

  imports = [
    ## Import Bore for certain ports
    ( import ./bore.nix {port = ports.CraftyUI; boreName="CraftyUI";} )
    ( import ./bore.nix {port = ports.TestMC; boreName="TestMC";} )
    ( import ./bore.nix {port = ports.TestVC; boreName="TestVC";} )

  ];



}
