{ pkgs, inputs, ... }: let
  unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
in {
  home.packages = with pkgs; [
    unstable.zotero
    calibre
  ];
  # maybe this goes into system config, since I want backups?
}
