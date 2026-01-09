{
  description = "Reusable NixOS user configurations";
  outputs =
    {
      comfyui_nix,
      nixpkgs,
      self,
    }@inputs:
    let
      import_modules = import ./resources/nix/import_modules.nix;
    in
    {
      inputs = inputs;
      nixosModules.default = {
        imports = (import_modules ./users) ++ [
          comfyui-nix.nixosModules.default
        ];
      };
    };
  inputs = {
    comfyui_nix = {
      url = "github:utensils/comfyui-nix";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };
}
