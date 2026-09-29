{
  osConfig,
  lib,
  pkgs,
  ...
}:

{
  home.packages = lib.mkIf (osConfig.metronome.audio.backend == "pipewire") [
    pkgs.pwvucontrol
  ];

}
