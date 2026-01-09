{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  nixpkgs.overlays = [ inputs.comfyui_nix.comfyui-nix.overlays.default ];

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
