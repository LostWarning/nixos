{
  config,
  lib,
  username,
  ...
}:

{
  options.custom.services.docker.enable = lib.mkEnableOption "docker";

  config = lib.mkIf config.custom.services.docker.enable {
    virtualisation.docker.enable = true;

    users.users.${username}.extraGroups = [ "docker" ];
  };
}
