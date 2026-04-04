{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.python3
  ];
}
