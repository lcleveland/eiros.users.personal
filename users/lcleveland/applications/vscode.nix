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
          version = "2.1.212";
          sha256 = "sha256-pPgl7MTzkBqZ/KatgAme7F6w873GLxZ1ZTYfkXzD4kw=";
        };
        postInstall = ''
          native_bin="$out/share/vscode/extensions/anthropic.claude-code/resources/native-binary/claude"
          rm -f "$native_bin"
          ln -sf ${pkgs.claude-code}/bin/claude "$native_bin"
        '';
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
