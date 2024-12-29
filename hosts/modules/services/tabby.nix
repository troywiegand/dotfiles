{ pkgs, ... }:
{
  # try this again in 24.11
  #services.tabby = {
  #  enable = true;
  #  port = 11029;
  #  acceleration = "cuda"; 
  #};
  networking.firewall.allowedTCPPorts = [ 11029 ];

  virtualisation.oci-containers.containers = {
    tabbyml = {
      image = "tabbyml/tabby:0.20.0";
      ports = [ "11029:8080" ];
      volumes = [
        "tabby:/data"
      ];
      environment = {};
      autoStart = true;
      extraOptions = [
        # docker run --rm -it --device=nvidia.com/gpu=1 ubuntu:latest nvidia-smi -L
        # GPU 0: NVIDIA GeForce RTX 2060 SUPER (UUID: <REDACTED>)
        "--device" "nvidia.com/gpu=1"
      ];
      cmd = [
        "serve"
        "--device" "cuda"
        "--model" "Qwen2.5-Coder-3B"
        #"--model" "DeepseekCoder-6.7B"
        # I'm not seeing why I would want this
        #"--chat-model" "Qwen2.5-Coder-1.5B-Instruct"
      ];
    };
  };

}
