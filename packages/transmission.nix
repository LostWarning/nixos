{ pkgs, ... }:

{
  services.transmission = {
    enable = true;
    openRPCPort = true; # Opens port 9091 in firewall automatically
    user = "stranger"; # Run under your user account

    settings = {
      download-dir = "/home/stranger/Downloads";
      incomplete-dir = "/home/stranger/Downloads/incomplete";
      incomplete-dir-enabled = true;

      # Web UI settings
      rpc-enable = true;
      rpc-bind-address = "0.0.0.0";
      rpc-port = 9091;
      rpc-whitelist-enabled = false;
    };
  };
}
