{ pkgs, ... }:

{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  environment.systemPackages = with pkgs; [
    btrfs-progs
  ];

  fileSystems."/data/steam" = {
    device = "/dev/disk/by-label/secondary-pool";
    fsType = "btrfs";
    options = [
      "subvol=@steam"
      "noatime"
      "nofail"
    ];
  };
}
