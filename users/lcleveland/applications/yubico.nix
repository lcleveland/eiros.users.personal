{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.environment.systemPackages = [
    pkgs.yubioath-flutter
  ];
}
