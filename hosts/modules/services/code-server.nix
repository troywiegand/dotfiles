{ ... }:
{
  ## Open Code Server to a Device on the Network
  networking.firewall.allowedTCPPorts = [ 4444 ];
  services.code-server = {
    enable = true;
    user   = "troy"; 
    host   = "0.0.0.0";
  };
}
