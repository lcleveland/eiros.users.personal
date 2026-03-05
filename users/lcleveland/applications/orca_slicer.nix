{
  config,
  lib,
  pkgs,
  ...
}:

let
  orcaSlicerSteam = pkgs.writeShellScriptBin "orca-slicer" ''
    set -euo pipefail

    # Prefer X11/XWayland for NVIDIA stability
    export GDK_BACKEND=x11
    unset WAYLAND_DISPLAY

    # Use system fontconfig but ensure writable cache
    export FONTCONFIG_FILE=/etc/fonts/fonts.conf
    export FONTCONFIG_PATH=/etc/fonts
    export FONTCONFIG_CACHE="''${XDG_CACHE_HOME:-$HOME/.cache}/fontconfig-orca"

    mkdir -p "$FONTCONFIG_CACHE"

    # Refresh cache quietly
    ${pkgs.fontconfig}/bin/fc-cache -r >/dev/null 2>&1 || true

    exec ${pkgs.steam-run}/bin/steam-run ${pkgs.orca-slicer}/bin/orca-slicer "$@"
  '';
in
{
  environment.systemPackages = [
    orcaSlicerSteam
  ];
}
