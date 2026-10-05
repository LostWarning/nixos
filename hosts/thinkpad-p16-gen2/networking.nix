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

    hostName = "thinkpad-p16-gen2";

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    networkmanager.enable = true;

  };
}
