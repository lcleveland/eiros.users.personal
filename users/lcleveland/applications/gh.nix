{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.gh
  ];
}
