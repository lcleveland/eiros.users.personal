{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.platformio-core
    ];
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        libgcc
      ];
    };
  };
}
