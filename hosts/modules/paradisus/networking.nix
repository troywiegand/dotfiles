{ config, lib, pkgs, ports, ... }:
{
  networking.firewall.allowedTCPPorts = builtins.attrValues ports;

  ## Import Bore for certain ports
  boreCraftyUI = import ./bore.nix {port = ports.CraftyUI; boreName="CraftyUI";};
  boreCraftyUI = import ./bore.nix {port = ports.MC.TestMC; boreName="TestMC";};
  boreCraftyUI = import ./bore.nix {port = ports.MC.TestVC; boreName="TestVC";};


}
