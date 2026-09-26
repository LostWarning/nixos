{ ... }:

{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
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
