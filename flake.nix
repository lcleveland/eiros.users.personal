{
  description = "Reusable NixOS user configurations";
  outputs =
    { nixpkgs, self }@inputs:
    let
      import_modules = import ./resources/nix/import_modules.nix;
      users = (import_modules ./users);
    in
    {
      inputs = inputs;
      nixosModules.default = users;
    };
  inputs = {
nixpkgs = {
      url = "github:nixos/nixpkgs?ref=25.11";
    };
  };
}
