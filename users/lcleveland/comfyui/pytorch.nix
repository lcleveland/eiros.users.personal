{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.environment.systemPackages = with pkgs; [
    pkgs.python314Packages.torch-bin
  ];
}
