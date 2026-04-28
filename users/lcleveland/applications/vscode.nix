{ pkgs, ... }:
{
  config.programs.vscode = {
    enable = true;
    package = pkgs.vscode.override {
      commandLineArgs = "--enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland --use-gl=egl";
    };
    extensions = with pkgs.vscode-extensions; [
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          publisher = "anthropic";
          name = "claude-code";
          version = "2.1.119";
          sha256 = "sha256-oCW7PLHuowpDeXeIHnI51yqK2tvHpw1mXaVCBF3s3ME=";
        };
      })
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
