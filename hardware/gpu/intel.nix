{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./common.nix
  ];

  metronome.hardware.gpu = lib.mkDefault "intel";

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
    ];
  };

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    libva-utils
  ];
}
