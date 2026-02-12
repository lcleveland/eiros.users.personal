{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    services.onlyoffice.enable = true;
  };
}
