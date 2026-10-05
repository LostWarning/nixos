{ ... }:

{
  networking = {

    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };

    hostName = "desktop";

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    networkmanager.enable = true;

  };
}
