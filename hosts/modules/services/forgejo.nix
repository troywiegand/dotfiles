{ ... }:
{
  services.forgejo = {
    enable = true;
    settings = {
      server = {
        HTTP_PORT = 5533;
      };
    };
  };
}
