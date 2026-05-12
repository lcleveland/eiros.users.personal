{ pkgs, ... }:
{
  config.environment.systemPackages = [
    pkgs.zed-editor
  ];
}
