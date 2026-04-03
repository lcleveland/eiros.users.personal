{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.nixfmt
  ];
}