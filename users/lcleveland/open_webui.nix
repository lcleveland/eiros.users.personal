{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    # Inline overlay: relax extract-msg dependency
    nixpkgs.overlays = [
      (final: prev: {
        python313Packages = prev.python313Packages.overrideScope (
          pyFinal: pyPrev: {
            extract-msg = pyPrev.extract-msg.overridePythonAttrs (old: {
              nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pyFinal.pythonRelaxDepsHook ];

              # relax beautifulsoup4<4.14 constraint
              pythonRelaxDeps = (old.pythonRelaxDeps or [ ]) ++ [ "beautifulsoup4" ];
            });
          }
        );
      })
    ];

    services.open-webui = {
      enable = true;
    };
  };
}
