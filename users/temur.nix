{ config, pkgs, inputs, ... }: 
{
  _module.args.inputs = inputs; # this is huge
  imports = [
    ./haley.nix

    ./modules/terminal

    ./modules/production/office.nix

    ./modules/games.nix
    ./modules/fonts.nix
    ./modules/flatpak.nix
    ./modules/networking.nix

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
      simple-scan
      sxiv
      pavucontrol
      vlc
      localsend
      arandr

      # hardware utilities
      # move to system
      acpi
      brightnessctl

      vscodium

      pdftk
      obsidian
      _1password-gui

      # dont exist yet with nixpkgs, but cargo install works
      #vtracer toml-cli ytop checkexec
      discord
    ];
  in stable-packages;



  home.stateVersion = "25.11";
}
