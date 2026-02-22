{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    environment.systemPackages = [
      pkgs.winboat
    ];
  };
}
