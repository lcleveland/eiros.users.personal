{ config, lib, ... }:
{
  config.nix.settings.trusted-users = [
    "root"
    "lcleveland"
  ];
}
