{
  config,
  lib,
  ...
}:

let
  cfg = config.metronome.networking;
in
{
  options.metronome.networking = {
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "System hostname";
    };

    nameservers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      description = "DNS nameservers";
    };

    networkmanager.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable NetworkManager";
    };

    firewall = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable the firewall";
      };

      allowedTCPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [
          80
          443
        ];
        description = "Allowed TCP ports through the firewall";
      };

      allowedUDPPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        description = "Allowed UDP ports through the firewall";
      };
    };
  };

  config = {
    networking = {
      hostName = cfg.hostName;
      nameservers = cfg.nameservers;
      networkmanager.enable = cfg.networkmanager.enable;
      firewall = {
        enable = cfg.firewall.enable;
        allowedTCPPorts = cfg.firewall.allowedTCPPorts;
        allowedUDPPorts = cfg.firewall.allowedUDPPorts;
      };
    };
  };
}
