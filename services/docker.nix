{
  config,
  lib,
  username,
  ...
}:

let
  containers = config.metronome.containers;
in
{

  config = lib.mkIf (containers.enable && containers.docker.enable) {
    virtualisation.docker.enable = true;

    users.users.${username}.extraGroups = [ "docker" ];
  };
}
