{ ... }:
{
    services.adguardhome = {
        enable = true;
        openFirewall = true;
        mutableSettings = true; # change later when I know what I'm doing

        #settings = {
        #    # check this: https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file
        #    bind_host = "192.168.50.3";
        #    bind_port = 3001;
        #};
    };

    networking.firewall = {
        allowedTCPPorts = [ 3001 ]; # web interface
        allowedUDPPorts = [ 53 ]; # dns
    };
}
