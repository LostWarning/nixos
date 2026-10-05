{ pkgs, ... }:

{
  users.users.stranger = {
    isNormalUser = true;
    description = "Amal C.S";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "docker"
    ];

    shell = pkgs.fish;
  };

  home-manager.users.stranger = {
    imports = [
      ../home.nix
    ];

  };
}
