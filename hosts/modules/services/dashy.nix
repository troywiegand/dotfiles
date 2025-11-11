{
  pkgs,
  config,
  lib,
  ...
}: let
  orzhov = "http://orzhov.hen-dinosaur.ts.net";
  secure-orzhov = "https://orzhov.hen-dinosaur.ts.net";

  dashy.port = 80;

  dashy_conf = pkgs.writers.writeYAML "conf.yml" {
    appConfig = {
      language = "en";
      layout = "auto";
      iconSize = "large";
      theme = "dracula";
      auth.enableGuestAccess = true;
    };
    pageInfo = {
      title = "Sapphire Ridge (hen-dinosaur)";
      navLinks = [];
    };
    sections = [
      {
        name = "Local Network";
        items = [
          {
            title = "Jellyfin";
            description = "Home media server";
            icon = "hl-jellyfin";
            url = "${orzhov}:8096";
          }
          {
            title = "Home Assistant";
            description = "Home automation";
            icon = "hl-home-assistant";
            url = "${orzhov}:8123";
          }
          {
            title = "Immich";
            description = "Photos";
            icon = "hl-immich";
            url = "${orzhov}:2283";
          }
          {
            title = "Paperless";
            description = "Document organization";
            icon = "hl-paperless";
            url = "${orzhov}:8000";
          }
          {
            title = "Router";
            description = "Home router";
            icon = "hl-at-t";
            url = "http://192.168.1.254";
          }
          {
            title = "Mealie";
            description = "Recipe manager";
            icon = "hl-mealie";
            url = "${orzhov}:9000";
          }
          {
            title = "Excalidraw";
            description = "Whiteboarding Tool";
            icon = "hl-excalidraw";
            url = "${orzhov}:5000";
          }
          {
            title = "Convertx";
            description = "File Conversions UI";
            icon = "hl-convertx";
            url = "${orzhov}:5001";
          }
          {
            title = "Stirling-PDF";
            description = "PDF tools";
            icon = "hl-stirling-pdf";
            url = "${orzhov}:5002";
          }
          {
            title = "IT Tools";
            description = "Misc IT tools";
            icon = "hl-it-tools";
            url = "${orzhov}:5003";
          }
        ];
      }
      {
        name = "Minecraft";
        items = [
          {
            title = "Crafty";
            description = "Manage MC Servers";
            url = "${secure-orzhov}:8443";
            icon = "hl-crafty-controller";
          }
        ];
      }
      {
        name = "Managed Services";
        items = [
          {
            title = "Tailscale";
            description = "Mesh VPN service";
            url = "https://login.tailscale.com/login";
            icon = "favicon";
          }
        ];
      }
    ];
  };
in {
  config.virtualisation.oci-containers = {
    containers = {
      dashy = {
        image = "lissy93/dashy";
        ports = ["${toString dashy.port}:8080"];
        autoStart = true;
        volumes = [
          "${dashy_conf}:/app/user-data/conf.yml"
        ];
        environment = {
          #NODE_ENV = "production";
        };
      };
    };
  };
}
