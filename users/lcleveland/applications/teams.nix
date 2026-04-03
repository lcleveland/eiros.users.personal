{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.teams-for-linux
  ];
}
