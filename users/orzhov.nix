{ config, pkgs, inputs, ... }: 
{
  _module.args.inputs = inputs; # this is huge
  imports = [
    ./troy.nix

    #./modules/terminal

    ./modules/production/video.nix
    ./modules/production/photo.nix
    ./modules/production/office.nix

    ./modules/games.nix
    ./modules/fonts.nix
    ./modules/flatpak.nix
    ./modules/databases.nix
    ./modules/networking.nix

    ./modules/browser.nix
    ./modules/reading.nix
  ];

  xdg.mimeApps = {
    enable = false;
    defaultApplications = {
      "application/pdf" = "zathura.desktop";
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = let 
    stable-packages = with pkgs; [
      # graphical applications
      zathura
      flameshot # x only?
      simple-scan
      sxiv
      pavucontrol
      bitwarden
      jellyfin-media-player
      vlc
      localsend
      handbrake

      # container and virtual machines
      distrobox

      # hardware utilities
      # move to system
      acpi
      brightnessctl

      rustdesk

      vscodium

      evil-helix
      pdftk
      inputs.ghostty.packages.x86_64-linux.default
      obsidian
      _1password-gui
      #nerd-fonts
      noto-fonts-emoji

      # dont exist yet with nixpkgs, but cargo install works
      #vtracer toml-cli ytop checkexec
      discord
    ];
    unstable-packages = with inputs.nixpkgs-unstable.legacyPackages.x86_64-linux; [
      freetube
      qbittorrent
    ];
  in stable-packages ++ unstable-packages;



  home.stateVersion = "24.05";
}
