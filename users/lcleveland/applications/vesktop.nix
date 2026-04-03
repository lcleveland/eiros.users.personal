{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.vesktop
  ];
}
