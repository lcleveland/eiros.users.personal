{ config, lib, ... }:
let
  viewTagBinds = builtins.listToAttrs (
    map (n: {
      name = "view_tag_${toString n}";
      value = {
        modifier_keys = [ "SUPER" ];
        flag_modifiers = [ "s" ];
        key_symbol = toString n;
        mangowc_command = "view";
        command_arguments = toString n;
      };
    }) (lib.range 1 9)
  );

  dirMap = {
    left = "h";
    right = "l";
    up = "k";
    down = "j";
  };

  mkDirBinds =
    prefix: cmd: mods: mkArgs:
    builtins.listToAttrs (
      lib.mapAttrsToList (dir: key: {
        name = "${prefix}_${dir}";
        value = {
          modifier_keys = mods;
          flag_modifiers = [ "s" ];
          key_symbol = key;
          mangowc_command = cmd;
          command_arguments = mkArgs dir;
        };
      }) dirMap
    );
in
{
  config.eiros.users.lcleveland = {
    mangowc = {
      keybinds =
        viewTagBinds
        // (mkDirBinds "switch_focus" "focusdir" [ "SUPER" ] (dir: dir))
        // (mkDirBinds "swap_window" "exchange_client" [ "SUPER" "SHIFT" ] (dir: dir))
        // (mkDirBinds "move_window_monitor" "tagmon" [ "CTRL" "SHIFT" ] (dir: "${dir},1"))
        // {
          launch_spotlight = lib.mkIf config.eiros.system.desktop_environment.dank_material_shell.enable {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "d";
            mangowc_command = "spawn_shell";
            command_arguments = "dms ipc call spotlight toggle";
          };
          close_window = {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "q";
            mangowc_command = "killclient";
          };
          quit_mangowc = {
            modifier_keys = [
              "SUPER"
              "SHIFT"
            ];
            flag_modifiers = [ "s" ];
            key_symbol = "q";
            mangowc_command = "quit";
          };
          launch_file_browser = {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "f";
            mangowc_command = "spawn";
            command_arguments = "ghostty -e yazi";
          };
          launch_terminal = {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "t";
            mangowc_command = "spawn";
            command_arguments = "ghostty";
          };
          window_toggle_float = {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "g";
            mangowc_command = "togglefloating";
          };
          window_toggle_maximize = {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "m";
            mangowc_command = "togglemaximizescreen";
          };
          overview_toggle = {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "Tab";
            mangowc_command = "toggleoverview";
          };
          reload_configuration = {
            modifier_keys = [
              "SUPER"
              "SHIFT"
            ];
            flag_modifiers = [ "s" ];
            key_symbol = "r";
            mangowc_command = "reload_config";
          };
          lock_screen = {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "Escape";
            mangowc_command = "spawn_shell";
            command_arguments = "dms ipc call lock lock";
          };
          night_mode_toggle = {
            modifier_keys = [ "SUPER" ];
            flag_modifiers = [ "s" ];
            key_symbol = "n";
            mangowc_command = "spawn_shell";
            command_arguments = "dms ipc call night toggle";
          };
          screenshot = {
            modifier_keys = [
              "SUPER"
              "SHIFT"
            ];
            flag_modifiers = [ "s" ];
            key_symbol = "s";
            mangowc_command = "spawn_shell";
            command_arguments = "dms screenshot --no-file";
          };
          paste_clipboard = {
            modifier_keys = [
              "CTRL"
              "SHIFT"
            ];
            flag_modifiers = [ "s" ];
            key_symbol = "v";
            mangowc_command = "spawn_shell";
            command_arguments = "dms cl paste | wtype -";
          };
        };
    };
  };
}
