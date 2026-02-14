{ config, lib, ... }:
let
  eiros_nvidia = config.eiros.system.hardware.graphics.nvidia;
in
{
  config.eiros_nvidia.open = false;
}
