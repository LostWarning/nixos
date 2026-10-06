{ lib, ... }:

let
  pipewireConfigFile = ./pipewire/99-2.1-crossover.conf;
in
{
  xdg.configFile."pipewire/pipewire.conf.d/99-system.conf" =
    lib.mkIf (builtins.pathExists pipewireConfigFile)
      {
        source = pipewireConfigFile;
      };
}
