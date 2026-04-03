{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.rusty-path-of-building
  ];
}
