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
      package = pkgs.ollama-cuda;
    };
  };
}
