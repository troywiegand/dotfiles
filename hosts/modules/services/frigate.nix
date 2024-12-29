{ pkgs, ... }:
{
  services.frigate = {
    enable = false;
    hostname = "rumnas.lynx-chromatic.ts.net"; # consider removing?
    settings = {
      #mqtt.enabled = true;
      cameras = {
        front = {
          enabled = true;
          ffmpeg.inputs = [
            {
              path = "rtsp://viewer:123123@10.0.10.10:554/live";
              roles = ["detect"];
            }
          ];
        };
      };
    };
  };
}
