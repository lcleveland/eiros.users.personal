{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      libgcc
    ];
  };
}
