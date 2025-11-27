{ config, ports, ... }:
{
  # https://wiki.nixos.org/wiki/Prometheus
  # https://nixos.org/manual/nixos/stable/#module-services-prometheus-exporters-configuration
  # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/default.nix
  services.prometheus = {
    enable = true;
    globalConfig.scrape_interval = "5m"; # "1m"
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = [ "localhost:${builtins.toString ports.Prometheus}" ];
        }];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings.server = {
      http_port = ports.Grafana;
      http_addr = "0.0.0.0";
    }; 

    provision = {
      enable = true;

      datasources.settings.datasources = [
          # Provisioning a built-in data source
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://${config.services.prometheus.listenAddress}:${builtins.toString config.services.prometheus.port}";
          isDefault = true;
          editable = false;
        }
      ];
    };
  };
}

