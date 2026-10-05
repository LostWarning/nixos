{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.metronome.apps.quickshell;
in
{

  options.metronome.apps.quickshell = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install quickshell";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.quickshell = {
      enable = true;
      package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    home.packages = with pkgs; [
      qt6.qtwayland
      qt6.qt5compat
      qt6.qtshadertools
      qt6.qtdeclarative
    ];
  };
}
