{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.overlays.fpLibvirt;

  # Fetch feel-co/fp at the exact commit.
  # This does NOT require it as a flake input; it fetches the repo as a source.
  fpSrc = builtins.fetchTarball {
    url = "https://github.com/feel-co/fp/archive/337cd82e8a07d0b2600846fc607e6706c5cd0042.tar.gz";
    # Optional but recommended: add sha256 for reproducibility.
    # Get it once via:
    #   nix-prefetch-url --unpack https://github.com/feel-co/fp/archive/337cd82e8a07d0b2600846fc607e6706c5cd0042.tar.gz
    # sha256 = "sha256-0ffyws293p3bb26ncrayb4k3b5ma9ssbljkxz2agp29mdjzxnqmy=";
  };

  # Import that nixpkgs-like tree for the same system.
  fpPkgs = import fpSrc {
    inherit (pkgs) system;
    config = pkgs.config;
  };

in
{
  options.my.overlays.fpLibvirt = {
    enable = lib.mkEnableOption "Overlay libvirt from feel-co/fp pinned commit";

    setAsLibvirtdPackage = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "If true, automatically set virtualisation.libvirtd.package = pkgs.libvirt.";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      (final: prev: {
        libvirt = fpPkgs.libvirt;
        # Add more overrides if needed:
        # virt-manager = fpPkgs.virt-manager;
        # libvirt-glib = fpPkgs.libvirt-glib;
      })
    ];

    # Optional convenience: point libvirtd at the overridden libvirt
    virtualisation.libvirtd.package = lib.mkIf cfg.setAsLibvirtdPackage (lib.mkDefault pkgs.libvirt);
  };
}
