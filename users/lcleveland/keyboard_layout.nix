{ config, lib, ... }:
let
  eiros_keyboard = config.eiros.system.hardware.keyboard;
in
{
  eiros_keyboard.variant = "colemak_dh";
}
