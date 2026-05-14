{ pkgs, ... }:
{
  config.environment.systemPackages = [ pkgs.orca-slicer ];
}
