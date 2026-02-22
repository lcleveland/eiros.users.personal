{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.eiros.system.boot.kernel.kernel_package = pkgs.linuxPackages_6_18;
}
