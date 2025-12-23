# users/lcleveland/applications/ninjaone.nix
{
  config,
  pkgs,
  lib,
  ...
}:

let
  version = "11.35.7720";

  # Typical runtime deps for vendor GUI apps; extend if autoPatchelf complains.
  runtimeDeps = [
    pkgs.stdenv.cc.cc
    pkgs.zlib
    pkgs.openssl
    pkgs.glib
    pkgs.gtk3
    pkgs.pango
    pkgs.cairo
    pkgs.mesa
    pkgs.libdrm
    pkgs.alsa-lib
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXrandr
    pkgs.xorg.libXdamage
    pkgs.xorg.libXfixes
    pkgs.xorg.libXi
    pkgs.xorg.libXrender
  ];

  runtimeLibPath = lib.makeLibraryPath runtimeDeps;

  ninjarmm-ncplayer = pkgs.stdenv.mkDerivation {
    pname = "ninjarmm-ncplayer";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://resources.ninjarmm.com/development/ninjacontrol/${version}/ninjarmm-ncplayer-${version}_x86_64.rpm";
      # Fill with:
      # nix store prefetch-file "https://resources.ninjarmm.com/development/ninjacontrol/11.35.7720/ninjarmm-ncplayer-11.35.7720_x86_64.rpm"
      hash = "sha256-maOFIZm0kbxzq6sJMHSdcWfAXbss4r2vPRxpG+Clvtw=";
    };

    nativeBuildInputs = [
      pkgs.rpm
      pkgs.cpio
      pkgs.autoPatchelfHook
      pkgs.makeWrapper
    ];

    # autoPatchelfHook uses these to satisfy DT_NEEDED libs
    buildInputs = runtimeDeps;

    unpackPhase = ''
      rpm2cpio "$src" | cpio -idm
    '';

    installPhase = ''
      mkdir -p "$out"
      if [ -d usr ]; then
        cp -R usr/* "$out/"
      else
        cp -R . "$out/"
      fi

      # This RPM commonly installs under /opt/ncplayer; expose a stable $out/bin/ncplayer.
      if [ -x "$out/opt/ncplayer/bin/ncplayer" ]; then
        mkdir -p "$out/bin"
        ln -sf "$out/opt/ncplayer/bin/ncplayer" "$out/bin/ncplayer"
      fi
    '';

    postFixup = ''
      # RPM contains build-id symlinks that point to /opt/... paths outside the Nix store.
      # Nix fails the build on dangling symlinks, so remove the build-id tree.
      rm -rf "$out/lib/.build-id" || true

      if [ -x "$out/bin/ncplayer" ]; then
        wrapProgram "$out/bin/ncplayer" \
          --prefix LD_LIBRARY_PATH : "${runtimeLibPath}" \
          --prefix XDG_DATA_DIRS : "$out/share"
      fi

      # Ensure a URL scheme handler desktop entry exists for ninjarmm:// links.
      mkdir -p "$out/share/applications"
      cat > "$out/share/applications/ninjarmm-ncplayer.desktop" <<'EOF'
      [Desktop Entry]
      Name=NinjaOne Remote
      Type=Application
      Terminal=false
      Exec=ncplayer -u %u
      MimeType=x-scheme-handler/ninjarmm;
      Categories=Network;RemoteAccess;
      EOF
    '';

    meta = with lib; {
      description = "NinjaOne / NinjaRMM Ninja Remote (ncplayer) packaged from RPM";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
    };
  };
in
{
  options.services.ninjaone = {
    enable = lib.mkEnableOption "NinjaOne Ninja Remote client (ncplayer)";

    package = lib.mkOption {
      type = lib.types.package;
      default = ninjarmm-ncplayer;
      description = "Package providing NinjaOne ncplayer (RPM repackaged).";
    };
  };

  config = {
    environment.systemPackages = [ config.services.ninjaone.package ];

    # Register ninjarmm:// handler
    xdg.mime.defaultApplications = {
      "x-scheme-handler/ninjarmm" = [ "ninjarmm-ncplayer.desktop" ];
    };
  };
}
