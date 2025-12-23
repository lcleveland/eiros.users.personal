{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    services.ollama = {
      enable = true;
      acceleration = "cuda";
      package = pkgs.ollama-cuda;
    };
  };
}
