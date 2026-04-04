{ config, lib, ... }:
let
  mkBind =
    mods: key: cmd: args:
    {
      modifier_keys = mods;
      flag_modifiers = [ "s" ];
      key_symbol = key;
      mangowc_command = cmd;
    }
    // (if args != null then { command_arguments = args; } else { });

  viewTagBinds = builtins.listToAttrs (
    map (n: {
      name = "view_tag_${toString n}";
      value = mkBind [ "SUPER" ] (toString n) "view" (toString n);
    }) (lib.range 1 9)
  );

  shiftedNumbers = [
    "exclam"
    "at"
    "numbersign"
    "dollar"
    "percent"
    "asciicircum"
    "ampersand"
    "asterisk"
    "parenleft"
  ];

  moveToTagBinds = builtins.listToAttrs (
    lib.imap1 (n: key: {
      name = "move_to_tag_${toString n}";
      value = mkBind [ "SUPER" ] key "tag" (toString n);
    }) shiftedNumbers
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
        value = mkBind mods key cmd (mkArgs dir);
      }) dirMap
    );
in
{
  config.eiros.users.lcleveland = {
    mangowc = {
      keybinds =
        viewTagBinds
        // moveToTagBinds
        // (mkDirBinds "switch_focus" "focusdir" [ "SUPER" ] (dir: dir))
        // (mkDirBinds "swap_window" "exchange_client" [ "SUPER" "SHIFT" ] (dir: dir))
        // (mkDirBinds "move_window_monitor" "tagmon" [ "CTRL" "SHIFT" ] (dir: "${dir},1"))
        // {
          launch_spotlight = lib.mkIf config.eiros.system.desktop_environment.dank_material_shell.enable (
            mkBind [ "SUPER" ] "d" "spawn_shell" "dms ipc call spotlight toggle"
          );
          close_window = mkBind [ "SUPER" ] "q" "killclient" null;
          quit_mangowc = mkBind [ "SUPER" "SHIFT" ] "q" "quit" null;
          launch_file_browser = mkBind [ "SUPER" ] "f" "spawn" "ghostty -e yazi";
          launch_terminal = mkBind [ "SUPER" ] "t" "spawn" "ghostty";
          window_toggle_float = mkBind [ "SUPER" ] "g" "togglefloating" null;
          window_toggle_maximize = mkBind [ "SUPER" ] "m" "togglemaximizescreen" null;
          overview_toggle = mkBind [ "SUPER" ] "Tab" "toggleoverview" null;
          reload_configuration = mkBind [ "SUPER" "SHIFT" ] "r" "reload_config" null;
          lock_screen = mkBind [ "SUPER" ] "Escape" "spawn_shell" "dms ipc call lock lock";
          night_mode_toggle = mkBind [ "SUPER" ] "n" "spawn_shell" "dms ipc call night toggle";
          screenshot = mkBind [ "SUPER" "SHIFT" ] "s" "spawn_shell" "dms screenshot --no-file";
          paste_clipboard = mkBind [ "CTRL" "SHIFT" ] "v" "spawn_shell" "dms cl paste | wtype -";
        };
    };
  };
}
