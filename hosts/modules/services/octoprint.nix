{ ... }: let
    username = "octoprint";
in {
    services.octoprint = {
        enable = true;
        port = 5000;
        openFirewall = true;
        user = username;
    };

    users.users.${username}.extraGroups = [ "video" ];
}
