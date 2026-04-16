{ pkgs, ... }:
{
  config.programs.vscode = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform,WaylandWindowDecorations"
      "--ozone-platform=wayland"
      "--use-gl=egl"
    ];
    extensions = with pkgs.vscode-extensions; [
      anthropic.claude-code
      continue.continue
      jnoortheen.nix-ide
      vscodevim.vim
      github.copilot-chat
      platformio.platformio-vscode-ide
      ms-vscode.cpptools-extension-pack
      ms-vscode.cpptools
    ];
  };
}
