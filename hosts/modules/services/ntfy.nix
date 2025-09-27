{...}: {
  services.ntfy-sh = {
    enable = true;
    settings.base-url = "http://orzhov.hen-dinosaur.ts.net";
    settings.listen-http = "0.0.0.0:2586";
  };
}
