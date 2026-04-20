{ pkgs, ... }:
{
  config.environment.systemPackages = [
    (pkgs.symlinkJoin {
      name = "awakened-poe-trade";
      paths = [ pkgs.awakened-poe-trade ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/awakened-poe-trade \
          --add-flags "--disable-gpu --no-overlay"
      '';
    })
  ];
}
