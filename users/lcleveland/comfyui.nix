{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  services.comfyui = {
    enable = true;
    cuda = true;
    enableManager = true;
    port = 8188;
    listenAddress = "127.0.0.1";
    dataDir = "/var/lib/comfyui";
    openFirewall = false;
  };
}
