{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      bambu-studio = prev.bambu-studio.overrideAttrs (oldAttrs: {
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ final.makeWrapper ];

        postInstall = (oldAttrs.postInstall or "") + ''
          wrapProgram $out/bin/bambu-studio \
            --set __GLX_VENDOR_LIBRARY_NAME mesa \
            --set __EGL_VENDOR_LIBRARY_FILENAMES "${final.mesa}/share/glvnd/egl_vendor.d/50_mesa.json" \
            --set MESA_LOADER_DRIVER_OVERRIDE zink \
            --set GALLIUM_DRIVER zink \
            --set WEBKIT_DISABLE_DMABUF_RENDERER 1
        '';
      });
    })
  ];

  environment.systemPackages = [
    pkgs.bambu-studio
  ];
}
