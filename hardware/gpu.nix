{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.metronome.hardware.gpu;
in
{
  options.metronome.hardware = {
    gpu = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "amd"
          "intel"
        ]
      );
      default = null;
      description = "Primary GPU vendor for hardware graphics and acceleration drivers";
    };
  };

  config = lib.mkMerge [
    # Universal graphics baseline when any GPU is selected
    (lib.mkIf (cfg != null) {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      environment.systemPackages = with pkgs; [
        clinfo
        vulkan-tools
      ];
    })

    # Intel-specific graphics, compute, and diagnostic tools
    (lib.mkIf (cfg == "intel") {
      hardware.graphics = {
        extraPackages = with pkgs; [
          intel-media-driver # Hardware video acceleration (VA-API Gen 9+)
          vpl-gpu-rt # QSV / oneVPL runtime for video decoding & encoding
          intel-compute-runtime # OpenCL / Level Zero for Intel GPUs
        ];

        extraPackages32 = with pkgs.pkgsi686Linux; [
          intel-media-driver
        ];
      };

      environment.systemPackages = with pkgs; [
        intel-gpu-tools # intel_gpu_top monitoring
        libva-utils # vainfo for checking VA-API capabilities
      ];
    })

    # AMD-specific graphics, kernel modules, and diagnostic tools
    (lib.mkIf (cfg == "amd") {
      hardware.graphics = {
        extraPackages = with pkgs; [
          mesa.opencl # OpenCL (RustiCL / Clover)
        ];
      };

      boot.initrd.kernelModules = [ "amdgpu" ];
      hardware.amdgpu.opencl.enable = true;

      environment.systemPackages = with pkgs; [
        lact # AMD GPU control daemon & overclocking GUI
        amdgpu_top # AMD GPU top monitor
      ];
    })
  ];
}
