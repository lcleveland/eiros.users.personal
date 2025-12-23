# users/lcleveland/applications/ninjaone.nix
{
  config,
  pkgs,
  lib,
  ...
}:

let
  version = "11.35.7720";

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
      hash = "sha256-maOFIZm0kbxzq6sJMHSdcWfAXbss4r2vPRxpG+Clvtw=";
    };

    nativeBuildInputs = [
      pkgs.rpm
      pkgs.cpio
      pkgs.autoPatchelfHook
      pkgs.makeWrapper
    ];

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

      # RPM commonly installs under /opt/ncplayer; expose stable $out/bin/ncplayer.
      if [ -x "$out/opt/ncplayer/bin/ncplayer" ]; then
        mkdir -p "$out/bin"
        ln -sf "$out/opt/ncplayer/bin/ncplayer" "$out/bin/ncplayer"
      fi
    '';

    postFixup = ''
      # Remove broken build-id symlinks from RPM.
      rm -rf "$out/lib/.build-id" || true

      if [ -x "$out/bin/ncplayer" ]; then
        wrapProgram "$out/bin/ncplayer" \
          --prefix LD_LIBRARY_PATH : "${runtimeLibPath}" \
          --prefix XDG_DATA_DIRS : "$out/share"
      fi
    '';

    meta = with lib; {
      description = "NinjaOne / NinjaRMM Ninja Remote (ncplayer) packaged from RPM";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
    };
  };

  # System-level desktop entry package (guaranteed to land in /run/current-system/sw/share/applications)
  ninjaoneDesktopEntry = pkgs.writeTextFile {
    name = "ninjarmm-ncplayer-desktop-entry";
    destination = "/share/applications/ninjarmm-ncplayer.desktop";
    text = ''
      [Desktop Entry]
      Name=NinjaOne Remote
      Type=Application
      Terminal=false
      Exec=${ninjarmm-ncplayer}/bin/ncplayer -u %u
      MimeType=x-scheme-handler/ninjarmm;
      Categories=Network;RemoteAccess;
    '';
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
    environment.systemPackages = [
      config.services.ninjaone.package
      ninjaoneDesktopEntry
    ];

    # Ensure .desktop files are linked into the system profile.
    environment.pathsToLink = (config.environment.pathsToLink or [ ]) ++ [ "/share/applications" ];

    # Set defaults in a place GIO reliably reads.
    environment.etc."xdg/mimeapps.list".text = ''
      [Default Applications]
      x-scheme-handler/ninjarmm=ninjarmm-ncplayer.desktop;

      [Added Associations]
      x-scheme-handler/ninjarmm=ninjarmm-ncplayer.desktop;
    '';
  };
}
