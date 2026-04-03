{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.gnumake
  ];
}
