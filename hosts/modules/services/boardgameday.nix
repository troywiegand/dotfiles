{ config, pkgs, ... }:
let
  bgdBackendPort = 4000;
  bgdFrontendPort = 5173;
in {
  environment.sessionVariables = {
    BGD_BACKEND_PORT = bgdBackendPort;
    BGD_FRONTEND_PORT = bgdFrontendPort;
  };

  networking.firewall.allowedTCPPorts = [ bgdBackendPort bgdFrontendPort ];
}
