{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.eiros.system.boot.kernel.kenel_package = pkgs.linuxPackages_6_12;
}
