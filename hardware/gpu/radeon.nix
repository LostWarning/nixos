{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa.opencl
    ];
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.amdgpu.opencl.enable = true;

  # GPU monitoring & diagnostic tools
  environment.systemPackages = with pkgs; [
    lact
    amdgpu_top
    clinfo
    vulkan-tools
  ];
}
