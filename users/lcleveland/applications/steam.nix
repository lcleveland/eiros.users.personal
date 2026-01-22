{ config, lib, ... }:
{
  config.programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
