{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.awakened-poe-trade
  ];
}
