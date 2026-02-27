{ pkgs, ... }:
let
  sphinx91Patch = pkgs.fetchpatch {
    url = "https://github.com/prometheusresearch/sphinxcontrib-newsfeed/commit/0d82eee.patch";
    # fill with `nix store prefetch-file --hash-type sha256 <url>`
    hash = "sha256-3dtXp7gWOuyX27GczaJlPWXHX8EO2uyS9AkoxJT5Rn4=";
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      python3Packages = prev.python3Packages.overrideScope (
        pyFinal: pyPrev: {
          sphinxcontrib-newsfeed = pyPrev.sphinxcontrib-newsfeed.overridePythonAttrs (old: {
            patches = (old.patches or [ ]) ++ [ sphinx91Patch ];
          });
        }
      );
    })
  ];
}
