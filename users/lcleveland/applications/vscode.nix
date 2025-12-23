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
      ms-windows-ai-studio.windows-ai-studio
    ];
  };
}
