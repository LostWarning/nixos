{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.apps.mpv.enable = lib.mkEnableOption "mpv";

  config = lib.mkIf config.custom.apps.mpv.enable {
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
