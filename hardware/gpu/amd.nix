{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./common.nix
  ];

  metronome.hardware.gpu = lib.mkDefault "amd";

  hardware.graphics.extraPackages = with pkgs; [
    mesa.opencl
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.amdgpu.opencl.enable = true;

  environment.systemPackages = with pkgs; [
    lact
    amdgpu_top
  ];
}
