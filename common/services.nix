{ ... }:

{

  # Storage, Mounting, and File Managers Support
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;

  # D-Bus broker implementation
  services.dbus.implementation = "broker";

  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true; # Optional GUI Bluetooth manager
  # services.printing.enable = true;

  # Power management services
  services.upower.enable = true;

  boot.initrd.systemd.network.wait-online.enable = false;
}
