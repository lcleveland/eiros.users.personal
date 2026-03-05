{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.environment.systemPackages = [
    pkgs.orca-slicer
  ];
}
