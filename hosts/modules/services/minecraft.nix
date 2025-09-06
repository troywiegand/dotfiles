{ ... }:
let
  reclaimPort = 25587;
in {
  users.groups.mc = {};
  networking.firewall.allowedTCPPorts = [ reclaimPort ];
  ## TO-DO: Move the container Definition Here
}
