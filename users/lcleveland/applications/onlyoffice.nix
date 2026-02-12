{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    environment.systemPackages = [ pkgs.onlyoffice-bin ];
  };
}
