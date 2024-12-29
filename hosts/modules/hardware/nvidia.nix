{ pkgs, config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = { 
    enable = true; 
    enable32Bit = true; 
  };

  hardware.nvidia-container-toolkit.enable = true;
  # consider removing...test this
  virtualisation.docker.enableNvidia = true;
  #virtualisation.docker.daemon.settings = {
  #  runtimes.nvidia = {
  #    path = "${pkgs.nvidia-container-toolkit}/bin/nvidia-container-runtime";
  #    runtimeArgs = [];
  #  };
  #};

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
}
