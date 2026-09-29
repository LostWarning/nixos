{
  osConfig,
  lib,
  pkgs,
  ...
}:

{
  home.packages = lib.mkIf (osConfig.custom.audio.backend == "pipewire") [
    pkgs.pwvucontrol
  ];

}
