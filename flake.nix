{
  description = "Reusable NixOS user configurations";
  outputs =
    { self }@inputs:
    let
      import_modules = import ./resources/nix/import_modules.nix;
      users = (import_modules ./users);
    in
    {
      inputs = inputs;
      nixosModules.default = users;
    };
  inputs = { };
}
