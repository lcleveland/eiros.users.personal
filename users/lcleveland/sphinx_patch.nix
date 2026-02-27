{ lib, pkgs, ... }:

let
  # Upstream fix is in prometheusresearch/sphinxcontrib-newsfeed PR #7 (merged),
  # commit 0d82eee. :contentReference[oaicite:1]{index=1}
  sphinx91Patch = pkgs.fetchpatch {
    url = "https://github.com/prometheusresearch/sphinxcontrib-newsfeed/commit/0d82eee.patch";
    # Fill this in with: nix store prefetch-file --hash-type sha256 <url>
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      python3Packages = prev.python3Packages.overrideScope' (
        pyFinal: pyPrev: {
          sphinxcontrib-newsfeed = pyPrev.sphinxcontrib-newsfeed.overridePythonAttrs (old: {
            patches = (old.patches or [ ]) ++ [ sphinx91Patch ];
          });
        }
      );
    })
  ];
}
