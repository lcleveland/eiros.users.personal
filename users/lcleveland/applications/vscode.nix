{
  config,
  lib,
  pkgs,
  ...
}:
{
  config.programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      vscodevim.vim
    ];
  };
}
