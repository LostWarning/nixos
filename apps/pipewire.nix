{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.pipewire;
  isDefault = (config.metronome.defaults.audio-backend == "pipewire");
in
{
  options.metronome.apps.pipewire = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = (cfg.configFile != null || isDefault);
      description = "Enable PipeWire user configuration";
    };

    configFile = lib.mkOption {
      type = lib.types.nullOr (lib.types.either lib.types.path lib.types.lines);
      default = null;
      description = "Path or content for the PipeWire user configuration (e.g. 99-system.conf)";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.configFile != null) {
    xdg.configFile."pipewire/pipewire.conf.d/99-system.conf" =
      if builtins.isPath cfg.configFile then
        { source = cfg.configFile; }
      else
        { text = cfg.configFile; };
  };
}
