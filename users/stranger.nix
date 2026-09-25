rec {
  username = "stranger";
  fullName = "Amal C.S";
  email = "amal4cs@gmail.com";

  nixosModule =
    { pkgs, ... }:

    {
      users.users.${username} = {
        isNormalUser = true;
        description = fullName;
        extraGroups = [
          "audio"
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.fish;
      };
    };
}
