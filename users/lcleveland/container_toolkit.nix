{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.hardware.nvidia-container-toolkit.enable = true;
}
