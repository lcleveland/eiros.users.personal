{ config, lib, ... }:
{
  config.environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # Still recommended on wlroots (even with open)
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
