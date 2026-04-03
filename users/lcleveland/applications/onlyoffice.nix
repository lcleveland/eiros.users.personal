{ pkgs, ... }:
{
  config.environment.systemPackages = [ pkgs.onlyoffice-desktopeditors ];
}
