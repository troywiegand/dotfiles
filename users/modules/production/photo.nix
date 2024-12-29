{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gimp
    gthumb
    upscayl # ai upscaler
    krita
  ];
}
