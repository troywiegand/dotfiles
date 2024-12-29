{ pkgs, ... }:
{
  # todo: replace with sops
  environment.etc."nextcloud-admin-pass".text = "exampleTest123";

  # nginx that is made runs on 80 and fails
  # not sure how to overwrite it
  # need to look at the module

  services.nextcloud = {
    hostName = "localhost";
    enable = true;
    package = pkgs.nextcloud29;
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
  };
}
