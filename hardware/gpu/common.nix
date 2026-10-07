{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.metronome.hardware = {
    gpu = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "amd"
          "intel"
          "nvidia"
        ]
      );
      default = null;
      description = "Primary GPU vendor for hardware graphics and acceleration drivers";
    };
  };

  config = lib.mkIf (config.metronome.hardware.gpu != null) {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      clinfo
      vulkan-tools
    ];
  };
}
