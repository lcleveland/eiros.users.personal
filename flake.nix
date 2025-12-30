{
  description = "Reusable NixOS user configurations";
  outputs =
    {
      comfyui,
      nixpkgs,
      self,
    }@inputs:
    let
      import_modules = import ./resources/nix/import_modules.nix;
    in
    {
      inputs = inputs;
      nixosModules.default = {
        imports = (import_modules ./users) ++ [ comfyui.nixosModules.default ];
        nixpkgs.overlays = [ comfyui.overlays.default ];
      };
    };
  inputs = {
    comfyui = {
      url = "github:utensils/comfyui-nix";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=25.11";
    };
  };
}
