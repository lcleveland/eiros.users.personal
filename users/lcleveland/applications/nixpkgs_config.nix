{ ... }:
{
  # awakened-poe-trade is built against electron-40.10.5, which nixpkgs now
  # marks insecure (EOL). Permit it so the configuration evaluates.
  config.nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];
}
