{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.apps.mpv;
in
{
  options.metronome.apps.mpv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install mpv";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      package = pkgs.mpv.override {
        mpv-unwrapped = pkgs.mpv-unwrapped.override {
          ffmpeg = pkgs.ffmpeg-full;
        };
      };
      config = {
        hwdec = "auto";
        vo = "gpu-next";
        gpu-api = "vulkan";

        target-colorspace-hint = "yes";

        tone-mapping = "spline";
        hdr-compute-peak = "auto";

        scale = "ewa_lanczossharp";
        cscale = "mitchell";
        dscale = "mitchell";

        dither-depth = "auto";
        dither = "fruit";

        audio-channels = "stereo,5.1,7.1";
        interpolation = "yes";
        tscale = "oversample";
      };

    };

  };
}
