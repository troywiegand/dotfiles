{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    borgbackup
  ];
}
