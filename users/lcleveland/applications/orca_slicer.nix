{
  config,
  lib,
  pkgs,
  ...
}:

let
  orcaSlicerSteam = pkgs.writeShellScriptBin "orca-slicer" ''
    set -euo pipefail

    export GDK_BACKEND=x11
    unset WAYLAND_DISPLAY

    export FONTCONFIG_FILE=/etc/fonts/fonts.conf
    export FONTCONFIG_PATH=/etc/fonts
    export FONTCONFIG_CACHE="''${XDG_CACHE_HOME:-$HOME/.cache}/fontconfig-orca"
    mkdir -p "$FONTCONFIG_CACHE"

    ${pkgs.fontconfig}/bin/fc-cache -r >/dev/null 2>&1 || true

    exec ${pkgs.steam-run}/bin/steam-run ${pkgs.orca-slicer}/bin/orca-slicer "$@"
  '';

  orcaDesktop = pkgs.makeDesktopItem {
    name = "orca-slicer-steam";
    desktopName = "OrcaSlicer (Steam)";
    comment = "OrcaSlicer wrapped with steam-run (fixes NVIDIA preview + fonts)";
    exec = "${orcaSlicerSteam}/bin/orca-slicer %U";
    icon = "OrcaSlicer";
    categories = [
      "Graphics"
      "Utility"
    ];
    terminal = false;
    startupWMClass = "OrcaSlicer";
  };
in
{
  environment.systemPackages = [
    orcaSlicerSteam
    orcaDesktop
    # optional: keep the original app installed too (for icon/resources/desktop file)
    pkgs.orca-slicer
  ];
}
