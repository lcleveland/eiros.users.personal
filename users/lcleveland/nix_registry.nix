{ ... }:
{
  nix.registry.eiros_users = {
    from = {
      type = "github";
      owner = "lcleveland";
      repo = "eiros.users";
    };
    to = {
      type = "github";
      owner = "lcleveland";
      repo = "eiros.users.personal";
    };
  };
}
