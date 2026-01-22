{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
