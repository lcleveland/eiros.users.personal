{ config, lib, ... }:
{
  config.eiros.users.lcleveland.extra_groups = lib.mkDefault [
    "wheel"
    "networkmanager"
    "libvirtd"
  ];
}
