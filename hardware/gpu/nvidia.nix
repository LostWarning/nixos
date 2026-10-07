{
  lib,
  ...
}:

{
  imports = [
    ./common.nix
  ];

  metronome.hardware.gpu = lib.mkDefault "nvidia";

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
  };
}
