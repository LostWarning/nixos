{ ... }:

{

  imports = [
    ./ssh-key.nix
  ];

  # Storage, Mounting, and File Managers Support
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;

  # Hardware, Networking, and Peripherals
  networking.networkmanager.enable = true;
  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true; # Optional GUI Bluetooth manager
  # services.printing.enable = true;

  # Power management services
  services.upower.enable = true;
}
