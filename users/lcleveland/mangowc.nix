{ config, lib, ... }:
let
  eiros_mangowc = eiros.users.lcleveland.mangowc;
in
{
  config = {
    eiros_mangowc.settings = {
      enable_hotarea = 0;
      ov_tab_mode = 1;
      idleinhibit_ignore_visible = 1;
      edge_scroller_pointer_focus = 0;
    };
  };
}
