{ pkgs, ... }:
{
  services.grafana = {
    enable = true;
    settings = {

      server = {
        http_addr = "0.0.0.0";
        http_port = 3000;
        domain = "rumtower.lynx-chromatic.ts.net";
      };

      security = {
        allow_embedding = true;
        cookie_samesite = "disabled";
      };
    };
  };
}
