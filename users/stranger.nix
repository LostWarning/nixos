rec {
  username = "stranger";
  fullName = "Amal C.S";
  email = "amal4cs@gmail.com";

  nixosModule =
    { config, pkgs, ... }:

    {
      users.users.${username} = {
        isNormalUser = true;
        description = fullName;
        extraGroups = [
          "audio"
          "networkmanager"
          "wheel"
          "docker"
        ];
        shell = pkgs.fish;
      };
    };
}
