{
  pkgs,
  ...
}:

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
      ../../../../common/xdg.nix
      ./packages.nix
      ./theme.nix
    ];

    home.username = "stranger";
    home.homeDirectory = "/home/stranger";

    programs.home-manager.enable = true;

    home.stateVersion = "26.05";

  };
}
